<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useRepuestos } from "@/composables/repuestos/useRepuestos";
import { useUsuarios } from "@/composables/usuarios/useUsuarios";
import { useUnidadAreas } from "@/composables/unidad_areas/useUnidadAreas";
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

const { oRepuesto, limpiarRepuesto } = useRepuestos();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
let form = useForm(oRepuesto.value);
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            form = useForm(oRepuesto.value);
            cargarListas();
        }
    }
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
    }
);

const { flash } = usePage().props;

const { getUsuariosByTipo } = useUsuarios();
const { getUnidadAreas } = useUnidadAreas();
const listUsuarios = ref([]);
const listUnidadAreas = ref([]);

const tituloDialog = computed(() => {
    return accion.value == 0 ? `Agregar Repuesto` : `Editar Repuesto`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("repuestos.store")
            : route("repuestos.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: () => {
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            limpiarRepuesto();
            emits("envio-formulario");
        },
        onError: (err) => {
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
        },
    });
};

const emits = defineEmits(["cerrar-dialog", "envio-formulario"]);

watch(dialog, (newVal) => {
    if (!newVal) {
        emits("cerrar-dialog");
    }
});

const cerrarDialog = () => {
    dialog.value = false;
};

const cargarListas = async () => {
    listUnidadAreas.value = await getUnidadAreas();
    listUsuarios.value = await getUsuariosByTipo("JEFE DE ÁREA");
};

onMounted(async () => {
    // cargarListas();
});
</script>

<template>
    <v-row justify="center">
        <v-dialog v-model="dialog" width="1024" persistent scrollable>
            <v-card>
                <v-card-title class="border-b bg-yellow-lighten-1 pa-5">
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
                        <form @submit.prevent="enviarFormulario">
                            <v-row>
                                <v-col cols="12" sm="6" md="6">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nombre ? false : true
                                        "
                                        :error="
                                            form.errors?.nombre ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.nombre
                                                ? form.errors?.nombre
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Nombre Repuesto*"
                                        required
                                        density="compact"
                                        v-model="form.nombre"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="6">
                                    <v-select
                                        :hide-details="
                                            form.errors?.unidad_area_id
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.unidad_area_id
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.unidad_area_id
                                                ? form.errors?.unidad_area_id
                                                : ''
                                        "
                                        no-data-text="No se encontrarón registros"
                                        density="compact"
                                        variant="outlined"
                                        clearable
                                        :items="listUnidadAreas"
                                        item-value="id"
                                        item-title="nombre"
                                        label="Seleccionar Área*"
                                        v-model="form.unidad_area_id"
                                        required
                                    ></v-select>
                                </v-col>
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
                        Cancelar
                    </v-btn>
                    <v-btn
                        class="bg-yellow-lighten-1"
                        prepend-icon="mdi-content-save"
                        @click="enviarFormulario"
                    >
                        Guardar
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-row>
</template>
