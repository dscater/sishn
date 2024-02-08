<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useServicios } from "@/composables/servicios/useServicios";
import { useSolicitudMantenimientos } from "@/composables/solicitud_mantenimientos/useSolicitudMantenimientos";
import { useMenu } from "@/composables/useMenu";
import { watch, ref, reactive, computed, onMounted } from "vue";

const { mobile, cambiarUrl } = useMenu();
const { oServicio, limpiarServicio } = useServicios();
let form = useForm(oServicio);

const { flash, auth } = usePage().props;
const user = ref(auth.user);
const { getSolicitudMantenimientos, getSolicitudMantenimientoById } =
    useSolicitudMantenimientos();
const listBiometricos = ref([]);

const tituloDialog = computed(() => {
    return oServicio.id == 0 ? `Agregar Servicio` : `Editar Servicio`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("servicios.store")
            : route("servicios.update", form.id);

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
            limpiarServicio();
            cambiarUrl(route("servicios.index"));
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

const cargaSolicitudMantenimientos = async () => {
    listBiometricos.value = await getSolicitudMantenimientos("desc");
};

const solicitud_mantenimiento = ref(null);

const obtenerSolicitudMantenimiento = async (value) => {
    if (value && value > 0) {
        solicitud_mantenimiento.value = await getSolicitudMantenimientoById(
            value
        );
    } else {
        solicitud_mantenimiento.value = null;
    }
};

onMounted(() => {
    if (form.id && form.id != "") {
        obtenerSolicitudMantenimiento(form.solicitud_mantenimiento_id);
    }
    cargaSolicitudMantenimientos();
});
</script>

<template>
    <v-row class="mt-0">
        <v-col cols="12" class="d-flex justify-end">
            <template v-if="mobile">
                <v-btn
                    icon="mdi-arrow-left"
                    class="mr-2"
                    @click="cambiarUrl(route('servicios.index'))"
                ></v-btn>
                <v-btn icon="mdi-content-save" color="yellow-lighten-1"></v-btn>
            </template>
            <template v-if="!mobile">
                <v-btn
                    prepend-icon="mdi-arrow-left"
                    class="mr-2"
                    @click="cambiarUrl(route('servicios.index'))"
                >
                    Volver</v-btn
                >
                <v-btn
                    :prepend-icon="
                        oServicio.id != 0 ? 'mdi-sync' : 'mdi-content-save'
                    "
                    color="yellow-lighten-1"
                    @click="enviarFormulario"
                >
                    <span
                        v-text="
                            oServicio.id != 0
                                ? 'Actualizar Servicio'
                                : 'Guardar Servicio'
                        "
                    ></span
                ></v-btn>
            </template>
        </v-col>
    </v-row>
    <v-row>
        <v-col cols="12" sm="12" md="4" xl="5">
            <v-card>
                <v-card-title class="border-b bg-yellow-lighten-1 pa-5">
                    <v-icon
                        :icon="form.id == 0 ? 'mdi-plus' : 'mdi-pencil'"
                    ></v-icon>
                    <span class="text-h5" v-html="tituloDialog"></span>
                </v-card-title>
                <v-card-text>
                    <v-container>
                        <form @submit.prevent="enviarFormulario">
                            <v-row
                                ><v-col cols="12" sm="12" md="12" xl="6">
                                    <v-select
                                        :hide-details="
                                            form.errors
                                                ?.solicitud_mantenimiento_id
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors
                                                ?.solicitud_mantenimiento_id
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors
                                                ?.solicitud_mantenimiento_id
                                                ? form.errors
                                                      ?.solicitud_mantenimiento_id
                                                : ''
                                        "
                                        clearable
                                        variant="outlined"
                                        label="Seleccionar Código de Solicitud de Mantenimiento*"
                                        :items="listBiometricos"
                                        item-value="id"
                                        item-title="codigo"
                                        required
                                        density="compact"
                                        @update:modelValue="
                                            obtenerSolicitudMantenimiento
                                        "
                                        v-model="
                                            form.solicitud_mantenimiento_id
                                        "
                                    ></v-select>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.fecha_entrega
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.fecha_entrega
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.fecha_entrega
                                                ? form.errors?.fecha_entrega
                                                : ''
                                        "
                                        variant="outlined"
                                        type="date"
                                        label="Fecha de Entrega*"
                                        required
                                        density="compact"
                                        v-model="form.fecha_entrega"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-textarea
                                        :hide-details="
                                            form.errors?.procedimientos
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.procedimientos
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.procedimientos
                                                ? form.errors?.procedimientos
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Procedimientos*"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.procedimientos"
                                    ></v-textarea>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-textarea
                                        :hide-details="
                                            form.errors?.observaciones
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.observaciones
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.observaciones
                                                ? form.errors?.observaciones
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Observaciones"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.observaciones"
                                    ></v-textarea>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-textarea
                                        :hide-details="
                                            form.errors?.recomendaciones
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.recomendaciones
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.recomendaciones
                                                ? form.errors?.recomendaciones
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Recomendaciones"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.recomendaciones"
                                    ></v-textarea>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-textarea
                                        :hide-details="
                                            form.errors?.diagnostico_previo
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.diagnostico_previo
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.diagnostico_previo
                                                ? form.errors
                                                      ?.diagnostico_previo
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Diagnóstico Previo"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.diagnostico_previo"
                                    ></v-textarea>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-textarea
                                        :hide-details="
                                            form.errors?.estado_equipo
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.estado_equipo
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.estado_equipo
                                                ? form.errors?.estado_equipo
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Estado del Equipo"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.estado_equipo"
                                    ></v-textarea>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-textarea
                                        :hide-details="
                                            form.errors?.trabajo_realizado
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.trabajo_realizado
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.trabajo_realizado
                                                ? form.errors?.trabajo_realizado
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Trabajo Realizado*"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.trabajo_realizado"
                                    ></v-textarea>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <div class="text-body-2 text-grey">
                                        Capacitcación
                                    </div>
                                    <v-switch
                                        hide-details
                                        color="success"
                                        true-value="SI"
                                        false-value="NO"
                                        v-model="form.capacitacion"
                                    >
                                        <template v-slot:label>
                                            <v-chip
                                                class="cursor-pointer"
                                                :color="
                                                    form.capacitacion == 'SI'
                                                        ? 'success'
                                                        : 'secondary'
                                                "
                                                :prepend-icon="
                                                    form.capacitacion == 'SI'
                                                        ? 'mdi-check'
                                                        : 'mdi-close'
                                                "
                                            >
                                                <span
                                                    v-text="form.capacitacion"
                                                ></span>
                                            </v-chip>
                                        </template>
                                    </v-switch>
                                </v-col>
                                <v-col
                                    cols="12"
                                    sm="12"
                                    md="12"
                                    xl="6"
                                    v-if="
                                        form.capacitacion &&
                                        form.capacitacion == 'SI'
                                    "
                                >
                                    <v-textarea
                                        :hide-details="
                                            form.errors?.descripcion
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.descripcion
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.descripcion
                                                ? form.errors?.descripcion
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Descripción*"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.descripcion"
                                    ></v-textarea>
                                </v-col>
                                <v-col
                                    cols="12"
                                    sm="12"
                                    md="12"
                                    xl="6"
                                    v-if="
                                        form.capacitacion &&
                                        form.capacitacion == 'SI'
                                    "
                                >
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
                                        variant="outlined"
                                        type="date"
                                        label="Fecha Inicio*"
                                        required
                                        density="compact"
                                        v-model="form.fecha_ini"
                                    ></v-text-field>
                                </v-col>
                                <v-col
                                    cols="12"
                                    sm="12"
                                    md="12"
                                    xl="6"
                                    v-if="
                                        form.capacitacion &&
                                        form.capacitacion == 'SI'
                                    "
                                >
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
                                        variant="outlined"
                                        type="date"
                                        label="Fecha Fin*"
                                        required
                                        density="compact"
                                        v-model="form.fecha_fin"
                                    ></v-text-field>
                                </v-col>
                            </v-row>
                        </form>
                    </v-container>
                </v-card-text>
            </v-card>
        </v-col>
        <v-col cols="12" sm="12" md="8" xl="7">
            <v-card>
                <v-card-title class="bg-yellow-lighten-1 pa-5">
                    <span class="text-h5">Información Servicio</span>
                </v-card-title>
                <v-card-item class="pa-0">
                    <v-row
                        v-if="
                            solicitud_mantenimiento &&
                            solicitud_mantenimiento.id != 0
                        "
                    >
                        <v-col cols="12">
                            <v-row class="mb-0 mt-0">
                                <v-col cols="4" class="text-right">
                                    <span
                                        class="text-body-2 text-medium-emphasis"
                                        >Código:</span
                                    >
                                </v-col>
                                <v-col cols="8">{{
                                    solicitud_mantenimiento.codigo
                                }}</v-col>
                            </v-row>
                            <v-row class="mb-0 mt-0">
                                <v-col cols="4" class="text-right">
                                    <span
                                        class="text-body-2 text-medium-emphasis"
                                        >Motivo Mantenimiento:</span
                                    >
                                </v-col>
                                <v-col cols="8">{{
                                    solicitud_mantenimiento.motivo_mantenimiento
                                }}</v-col>
                            </v-row>
                            <v-row class="mb-0 mt-0">
                                <v-col cols="4" class="text-right">
                                    <span
                                        class="text-body-2 text-medium-emphasis"
                                        >Fecha Solicitud:</span
                                    >
                                </v-col>
                                <v-col cols="8">{{
                                    solicitud_mantenimiento.fecha_solicitud_t
                                }}</v-col>
                            </v-row>
                            <v-row class="mb-0 mt-0">
                                <v-col cols="4" class="text-right">
                                    <span
                                        class="text-body-2 text-medium-emphasis"
                                        >Equipo:</span
                                    >
                                </v-col>
                                <v-col cols="8">
                                    <v-row>
                                        <v-col cols="12" class="pb-0">{{
                                            solicitud_mantenimiento.biometrico
                                                .nombre
                                        }}</v-col>
                                        <v-col cols="12">
                                            <v-chip
                                                color="yellow-darken-3"
                                                class="text-caption text-small"
                                                ><span
                                                    class="text-caption text-medium-emphasis"
                                                    >Marca:
                                                </span>
                                                {{
                                                    solicitud_mantenimiento
                                                        .biometrico.marca
                                                }}</v-chip
                                            >
                                            <v-chip
                                                color="yellow-darken-3"
                                                class="text-caption text-small"
                                                ><span
                                                    class="text-caption text-medium-emphasis"
                                                    >Modelo:
                                                </span>
                                                {{
                                                    solicitud_mantenimiento
                                                        .biometrico.modelo
                                                }}</v-chip
                                            >
                                            <v-chip
                                                color="yellow-darken-3"
                                                class="text-caption text-small"
                                                ><span
                                                    class="text-caption text-medium-emphasis"
                                                    >Serie:
                                                </span>
                                                {{
                                                    solicitud_mantenimiento
                                                        .biometrico.serie
                                                }}</v-chip
                                            >
                                        </v-col>
                                    </v-row>
                                </v-col>
                            </v-row>
                            <v-row class="mb-0 mt-0">
                                <v-col cols="4" class="text-right">
                                    <span
                                        class="text-body-2 text-medium-emphasis"
                                        >Ubicación Equipo:</span
                                    >
                                </v-col>
                                <v-col cols="8">
                                    <v-row>
                                        <v-col cols="12" class="pb-0">{{
                                            solicitud_mantenimiento.biometrico
                                                .unidad_area.ubicacion
                                        }}</v-col>
                                        <v-col cols="12">
                                            <v-chip
                                                color="yellow-darken-3"
                                                class="text-caption text-small"
                                            >
                                                {{
                                                    solicitud_mantenimiento
                                                        .biometrico.unidad_area
                                                        .nombre
                                                }}</v-chip
                                            >
                                        </v-col>
                                    </v-row></v-col
                                >
                            </v-row>
                            <v-row class="mb-0 mt-0">
                                <v-col cols="4" class="text-right">
                                    <span
                                        class="text-body-2 text-medium-emphasis"
                                        >Responsable:</span
                                    >
                                </v-col>
                                <v-col cols="8">{{
                                    solicitud_mantenimiento.nombre_responsable
                                }}</v-col>
                            </v-row>
                            <v-row class="mb-0 mt-0">
                                <v-col cols="4" class="text-right">
                                    <span
                                        class="text-body-2 text-medium-emphasis"
                                        >Técnico:</span
                                    >
                                </v-col>
                                <v-col cols="8">{{
                                    solicitud_mantenimiento.nombre_tecnico
                                }}</v-col>
                            </v-row>
                            <v-row class="mb-0 mt-0">
                                <v-col cols="4" class="text-right">
                                    <span
                                        class="text-body-2 text-medium-emphasis"
                                        >Tipo de Mantenimiento:</span
                                    >
                                </v-col>
                                <v-col cols="8">{{
                                    solicitud_mantenimiento.tipo_mantenimiento
                                }}</v-col>
                            </v-row>
                        </v-col>
                    </v-row>
                    <v-row v-else>
                        <v-col cols="12" class="text-center pa-5">
                            <span
                                class="text-body-2 text-mediem-emphasis text-grey"
                                >Debes seleccionar una Solicitud de
                                Mantenimiento</span
                            >
                        </v-col>
                    </v-row>
                </v-card-item>
            </v-card>
        </v-col>
    </v-row>
</template>
