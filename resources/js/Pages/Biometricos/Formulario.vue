<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useBiometricos } from "@/composables/biometricos/useBiometricos";
import { useUnidadAreas } from "@/composables/unidad_areas/useUnidadAreas";
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
const { getUnidadAreas } = useUnidadAreas();
const { getEmpresas } = useEmpresas();

const listEmpresas = ref([]);
const listUnidadAreas = ref([]);

const { oBiometrico, limpiarBiometrico } = useBiometricos();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
let form = useForm(oBiometrico.value);
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            form = useForm(oBiometrico.value);
            cargarEmpreas();
            cargarUnidadAreas();
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

const foto = ref(null);
const manual_usuario = ref(null);
const manual_servicio = ref(null);
function cargaArchivo(e, key) {
    form[key] = null;
    form[key] = e.target.files[0];
}

const tituloDialog = computed(() => {
    return accion.value == 0
        ? `Agregar Equipo Biomédico`
        : `Editar Equipo Biomédico`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("biometricos.store")
            : route("biometricos.update", form.id);

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
            limpiarBiometrico();
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

const cargarEmpreas = async () => {
    listEmpresas.value = await getEmpresas();
};
const cargarUnidadAreas = async () => {
    listUnidadAreas.value = await getUnidadAreas();
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
                                        label="Nombre Equipo*"
                                        required
                                        density="compact"
                                        v-model="form.nombre"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.estado ? false : true
                                        "
                                        :error="
                                            form.errors?.estado ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.estado
                                                ? form.errors?.estado
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Estado"
                                        v-model="form.estado"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.marca ? false : true
                                        "
                                        :error="
                                            form.errors?.marca ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.marca
                                                ? form.errors?.marca
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Marca"
                                        v-model="form.marca"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.serie ? false : true
                                        "
                                        :error="
                                            form.errors?.serie ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.serie
                                                ? form.errors?.serie
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Serie"
                                        v-model="form.serie"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.modelo ? false : true
                                        "
                                        :error="
                                            form.errors?.modelo ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.modelo
                                                ? form.errors?.modelo
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Modelo"
                                        v-model="form.modelo"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.fecha_ingreso
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.fecha_ingreso
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.fecha_ingreso
                                                ? form.errors?.fecha_ingreso
                                                : ''
                                        "
                                        type="date"
                                        density="compact"
                                        variant="outlined"
                                        label="Fecha de Ingreso*"
                                        v-model="form.fecha_ingreso"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-select
                                        :hide-details="
                                            form.errors?.garantia ? false : true
                                        "
                                        :error="
                                            form.errors?.garantia ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.garantia
                                                ? form.errors?.garantia
                                                : ''
                                        "
                                        no-data-text="Sin datos"
                                        density="compact"
                                        variant="outlined"
                                        clearable
                                        :items="['SI', 'NO']"
                                        label="Garantía"
                                        v-model="form.garantia"
                                        required
                                    ></v-select>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.cod_hdn ? false : true
                                        "
                                        :error="
                                            form.errors?.cod_hdn ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.cod_hdn
                                                ? form.errors?.cod_hdn
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        label="Código H.D.N.*"
                                        v-model="form.cod_hdn"
                                        required
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-file-input
                                        :hide-details="
                                            form.errors?.manual_usuario
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.manual_usuario
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.manual_usuario
                                                ? form.errors?.manual_usuario
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        placeholder="Manual de usuario"
                                        label="Manual de usuario"
                                        accept=".doc, .docx, .pdf, .xlsx, .xls"
                                        @change="
                                            cargaArchivo(
                                                $event,
                                                'manual_usuario'
                                            )
                                        "
                                        ref="manual_usuario"
                                    ></v-file-input>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-file-input
                                        :hide-details="
                                            form.errors?.manual_servicio
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.manual_servicio
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.manual_servicio
                                                ? form.errors?.manual_servicio
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        placeholder="Manual de servicio"
                                        label="Manual de servicio"
                                        accept=".doc, .docx, .pdf, .xlsx, .xls"
                                        @change="
                                            cargaArchivo(
                                                $event,
                                                'manual_servicio'
                                            )
                                        "
                                        ref="manual_servicio"
                                    ></v-file-input>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
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
                                        no-data-text="Sin datos"
                                        density="compact"
                                        variant="outlined"
                                        clearable
                                        :items="listUnidadAreas"
                                        item-value="id"
                                        item-title="nombre"
                                        label="Seleccionar Unidad/Área*"
                                        v-model="form.unidad_area_id"
                                        required
                                    ></v-select>
                                </v-col>
                                <v-col
                                    cols="12"
                                    sm="6"
                                    md="4"
                                    v-if="form.garantia == 'SI'"
                                >
                                    <v-select
                                        :hide-details="
                                            form.errors?.empresa_id
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.empresa_id
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.empresa_id
                                                ? form.errors?.empresa_id
                                                : ''
                                        "
                                        no-data-text="Sin datos"
                                        density="compact"
                                        variant="outlined"
                                        clearable
                                        :items="listEmpresas"
                                        item-value="id"
                                        item-title="nombre"
                                        label="Seleccionar Empresa*"
                                        v-model="form.empresa_id"
                                        required
                                    ></v-select>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-file-input
                                        :hide-details="
                                            form.errors?.foto ? false : true
                                        "
                                        :error="
                                            form.errors?.foto ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.foto
                                                ? form.errors?.foto
                                                : ''
                                        "
                                        density="compact"
                                        variant="outlined"
                                        accept="image/png, image/jpeg, image/bmp, image/webp"
                                        placeholder="Imagen"
                                        prepend-icon="mdi-camera"
                                        label="Imagen"
                                        @change="cargaArchivo($event, 'foto')"
                                        ref="foto"
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
