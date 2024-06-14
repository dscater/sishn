<script setup>
import { useSolicitudMantenimientos } from "@/composables/solicitud_mantenimientos/useSolicitudMantenimientos";
import { usePage } from "@inertiajs/vue3";
import { watch, ref, computed, defineEmits, onMounted } from "vue";
const props = defineProps({
    open_dialog: {
        type: Boolean,
        default: false,
    },
    accion_dialog: {
        type: Number,
        default: 0,
    },
});

const { oCronograma } = useSolicitudMantenimientos();

const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
const errors = ref({});
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
    }
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
    }
);

const tituloDialog = computed(() => {
    return accion.value == 0 ? `Agregar Cronograma` : `Editar Cronograma`;
});

const txtBtnGuardar = computed(() => {
    return accion.value == 0 ? `Agregar` : `Actualizar`;
});

const agregarCronograma = () => {
    if (
        oCronograma.value.date.trim() != "" &&
        oCronograma.value.descripcion.trim() != ""
    ) {
        emits("envio-formulario");
    } else {
        Swal.fire({
            icon: "error",
            title: "Error",
            text: `Debes ingresar la fecha y la descripción del cronograma`,
            confirmButtonColor: "#3085d6",
            confirmButtonText: `Aceptar`,
        });
    }
};

const eliminarEvento = () => {
    emits("evento-eliminado");
};

const emits = defineEmits([
    "cerrar-dialog",
    "envio-formulario",
    "evento-eliminado",
]);

watch(dialog, (newVal) => {
    if (!newVal) {
        emits("cerrar-dialog");
    }
});

const cerrarDialog = () => {
    dialog.value = false;
};

const user = usePage().props.auth.user;
onMounted(async () => {});
</script>

<template>
    <v-row justify="center">
        <v-dialog v-model="dialog" width="1024" persistent scrollable>
            <v-card>
                <v-card-title class="border-b bg-indigo-darken-4 pa-5">
                    <v-icon
                        icon="mdi-close"
                        class="float-right"
                        @click="cerrarDialog"
                    ></v-icon>

                    <v-icon
                        :icon="accion == 0 ? 'mdi-plus' : 'mdi-pencil'"
                    ></v-icon>
                    <span class="text-h5" v-html="tituloDialog"></span>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <form>
                            <v-row>
                                <template
                                    v-if="
                                        oCronograma.id == '' ||
                                        oCronograma.user_id == user.id
                                    "
                                >
                                    <v-col cols="12" sm="12" md="12">
                                        <v-text-field
                                            :hide-details="
                                                errors?.date ? false : true
                                            "
                                            :error="errors?.date ? true : false"
                                            :error-messages="
                                                errors?.date ? errors?.date : ''
                                            "
                                            type="date"
                                            variant="outlined"
                                            label="Fecha"
                                            density="compact"
                                            v-model="oCronograma.date"
                                        ></v-text-field>
                                    </v-col>
                                    <v-col cols="12" sm="12" md="12">
                                        <v-textarea
                                            :hide-details="
                                                errors?.descripcion
                                                    ? false
                                                    : true
                                            "
                                            :error="
                                                errors?.descripcion
                                                    ? true
                                                    : false
                                            "
                                            :error-messages="
                                                errors?.descripcion
                                                    ? errors?.descripcion
                                                    : ''
                                            "
                                            variant="outlined"
                                            label="Descripción"
                                            rows="1"
                                            auto-grow
                                            density="compact"
                                            v-model="oCronograma.descripcion"
                                        ></v-textarea>
                                    </v-col>
                                </template>
                                <template v-else> 
                                    <v-col cols="12">
                                        <v-row>
                                            <v-col cols="4" class="text-body-2 text-right">Fecha:</v-col>
                                            <v-col cols="8">{{ oCronograma.date }}</v-col>
                                        </v-row>
                                        <v-row>
                                            <v-col cols="4" class="text-body-2 text-right">Descripción:</v-col>
                                            <v-col cols="8">{{ oCronograma.descripcion }}</v-col>
                                        </v-row>
                                    </v-col>
                                </template>
                            </v-row>
                        </form>
                    </v-container>
                </v-card-text>
                <v-card-actions class="border-t">
                    <v-spacer></v-spacer>
                    <v-btn
                        color="grey-darken-4"
                        variant="text"
                        @click="cerrarDialog"
                    >
                        Cerrar
                    </v-btn>
                    <v-btn
                        v-if="
                            accion == 1 &&
                            (oCronograma.id == '' ||
                                oCronograma.user_id == user.id)
                        "
                        class="bg-red-darken-3"
                        prepend-icon="mdi-trash-can"
                        @click="eliminarEvento"
                    >
                        Eliminar
                    </v-btn>
                    <v-btn
                        v-if="
                            oCronograma.id == '' ||
                            oCronograma.user_id == user.id
                        "
                        class="bg-indigo-darken-4"
                        :prepend-icon="
                            accion == 1 ? 'mdi-sync' : 'mdi-content-save'
                        "
                        @click="agregarCronograma"
                    >
                        <span v-text="txtBtnGuardar"></span>
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-row>
</template>
