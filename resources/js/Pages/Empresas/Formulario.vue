<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useEmpresas } from "@/composables/empresas/useEmpresas";
import { watch, ref, computed, defineEmits } from "vue";
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

const { oEmpresa, limpiarEmpresa } = useEmpresas();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
let form = useForm(oEmpresa.value);
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            form = useForm(oEmpresa.value);
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

const logo = ref(null);
function cargaArchivo(e, key) {
    form[key] = null;
    form[key] = e.target.files[0];
}

const tituloDialog = computed(() => {
    return accion.value == 0 ? `Agregar Empresa` : `Editar Empresa`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("empresas.store")
            : route("empresas.update", form.id);

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
            limpiarEmpresa();
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
                        <form>
                            <v-row>
                                <v-col cols="12" sm="6" md="4">
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
                                        label="Nombre Empresa*"
                                        required
                                        density="compact"
                                        v-model="form.nombre"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nit ? false : true
                                        "
                                        :error="form.errors?.nit ? true : false"
                                        :error-messages="
                                            form.errors?.nit
                                                ? form.errors?.nit
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Nit"
                                        v-model="form.nit"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.fono ? false : true
                                        "
                                        :error="
                                            form.errors?.fono ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.fono
                                                ? form.errors?.fono
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Teléfono"
                                        v-model="form.fono"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.fecha_ini
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.fecha_ini
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.fecha_ini
                                                ? form.errors?.fecha_ini
                                                : ''
                                        "
                                        type="date"
                                        density="compact"
                                        variant="outlined"
                                        label="Fecha Inicio"
                                        v-model="form.fecha_ini"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.fecha_fin
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.fecha_fin
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.fecha_fin
                                                ? form.errors?.fecha_fin
                                                : ''
                                        "
                                        type="date"
                                        density="compact"
                                        variant="outlined"
                                        label="Fecha Fin"
                                        v-model="form.fecha_fin"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.correo ? false : true
                                        "
                                        :error="
                                            form.errors?.correo ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.correo
                                                ? form.errors?.correo
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Correo"
                                        v-model="form.correo"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.dir ? false : true
                                        "
                                        :error="form.errors?.dir ? true : false"
                                        :error-messages="
                                            form.errors?.dir
                                                ? form.errors?.dir
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Dirección"
                                        v-model="form.dir"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.pais ? false : true
                                        "
                                        :error="
                                            form.errors?.pais ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.pais
                                                ? form.errors?.pais
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="País"
                                        v-model="form.pais"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-file-input
                                        :hide-details="
                                            form.errors?.logo ? false : true
                                        "
                                        :error="
                                            form.errors?.logo ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.logo
                                                ? form.errors?.logo
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        accept="image/png, image/jpeg, image/bmp, image/webp"
                                        placeholder="Logo"
                                        prepend-icon="mdi-camera"
                                        label="Logo"
                                        @change="cargaArchivo($event, 'logo')"
                                        ref="logo"
                                    ></v-file-input>
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
