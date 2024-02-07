<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useSolicitudMantenimientos } from "@/composables/solicitud_mantenimientos/useSolicitudMantenimientos";
import { useBiometricos } from "@/composables/biometricos/useBiometricos";
import { useRepuestos } from "@/composables/repuestos/useRepuestos";
import { useMenu } from "@/composables/useMenu";
import Cronograma from "./Cronograma.vue";
import { watch, ref, computed, defineEmits, onMounted } from "vue";

const { mobile, cambiarUrl } = useMenu();
const { oSolicitudMantenimiento, limpiarSolicitudMantenimiento } =
    useSolicitudMantenimientos();
let form = useForm(oSolicitudMantenimiento);

const { flash, auth } = usePage().props;
const user = ref(auth.user);
const listTipoMantenimientos = ref(["CORRECTIVO", "PREVENTIVO"]);
const { getBiometricos } = useBiometricos();
const { getRepuestos } = useRepuestos();
const listBiometricos = ref([]);
const listRepuestos = ref([]);

const tituloDialog = computed(() => {
    return oSolicitudMantenimiento.id == 0
        ? `Agregar Solicitud de Mantenimiento`
        : `Editar Solicitud de Mantenimiento`;
});

const enviarFormulario = () => {
    form.cronogramas = oSolicitudMantenimiento.cronogramas;
    form.eliminados = oSolicitudMantenimiento.eliminados;
    let url =
        form["_method"] == "POST"
            ? route("solicitud_mantenimientos.store")
            : route("solicitud_mantenimientos.update", form.id);

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
            limpiarSolicitudMantenimiento();
            cambiarUrl(route("solicitud_mantenimientos.index"));
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

const cargarBiometricos = async () => {
    listBiometricos.value = await getBiometricos();
};

const cargarRepuestos = async () => {
    listBiometricos.value = await getBiometricos();
    listRepuestos.value = await getRepuestos();
};

onMounted(() => {
    form = useForm(oSolicitudMantenimiento);
    cargarBiometricos();
    cargarRepuestos();
});
</script>

<template>
    <v-row class="mt-0">
        <v-col cols="12" class="d-flex justify-end">
            <template v-if="mobile">
                <v-btn
                    icon="mdi-arrow-left"
                    class="mr-2"
                    @click="cambiarUrl(route('solicitud_mantenimientos.index'))"
                ></v-btn>
                <v-btn icon="mdi-content-save" color="yellow-lighten-1"></v-btn>
            </template>
            <template v-if="!mobile">
                <v-btn
                    prepend-icon="mdi-arrow-left"
                    class="mr-2"
                    @click="cambiarUrl(route('solicitud_mantenimientos.index'))"
                >
                    Volver</v-btn
                >
                <v-btn
                    :prepend-icon="
                        oSolicitudMantenimiento.id != 0
                            ? 'mdi-sync'
                            : 'mdi-content-save'
                    "
                    color="yellow-lighten-1"
                    @click="enviarFormulario"
                >
                    <span
                        v-text="
                            oSolicitudMantenimiento.id != 0
                                ? 'Actualizar Solicitud'
                                : 'Guardar Solicitud'
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
                            <v-row>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nombre_responsable
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nombre_responsable
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nombre_responsable
                                                ? form.errors
                                                      ?.nombre_responsable
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Nombre Completo Responsable*"
                                        required
                                        density="compact"
                                        v-model="form.nombre_responsable"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.ci_responsable
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.ci_responsable
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.ci_responsable
                                                ? form.errors?.ci_responsable
                                                : ''
                                        "
                                        variant="outlined"
                                        label="C.I. Responsable"
                                        required
                                        density="compact"
                                        v-model="form.ci_responsable"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.nombre_tecnico
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.nombre_tecnico
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.nombre_tecnico
                                                ? form.errors?.nombre_tecnico
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Nombre Completo Técnico"
                                        required
                                        density="compact"
                                        v-model="form.nombre_tecnico"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.ci_tecnico
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.ci_tecnico
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.ci_tecnico
                                                ? form.errors?.ci_tecnico
                                                : ''
                                        "
                                        variant="outlined"
                                        label="C.I. Técnico"
                                        required
                                        density="compact"
                                        v-model="form.ci_tecnico"
                                    ></v-text-field>
                                </v-col>
                                <v-col
                                    cols="12"
                                    sm="12"
                                    md="12"
                                    xl="6"
                                    v-if="user.tipo == 'TÉCNICO'"
                                >
                                    <v-select
                                        :hide-details="
                                            form.errors?.tipo_mantenimiento
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.tipo_mantenimiento
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.tipo_mantenimiento
                                                ? form.errors
                                                      ?.tipo_mantenimiento
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Tipo de Mantenimiento"
                                        :items="listTipoMantenimientos"
                                        required
                                        density="compact"
                                        v-model="form.tipo_mantenimiento"
                                    ></v-select>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-textarea
                                        :hide-details="
                                            form.errors?.motivo_mantenimiento
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.motivo_mantenimiento
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.motivo_mantenimiento
                                                ? form.errors
                                                      ?.motivo_mantenimiento
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Motivo de Mantenimiento*"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.motivo_mantenimiento"
                                    ></v-textarea>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-textarea
                                        :hide-details="
                                            form.errors?.diagnostico
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.diagnostico
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.diagnostico
                                                ? form.errors?.diagnostico
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Diagnostico"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.diagnostico"
                                    ></v-textarea>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-textarea
                                        :hide-details="
                                            form.errors?.otros ? false : true
                                        "
                                        :error="
                                            form.errors?.otros ? true : false
                                        "
                                        :error-messages="
                                            form.errors?.otros
                                                ? form.errors?.otros
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Otros"
                                        rows="1"
                                        auto-grow
                                        density="compact"
                                        v-model="form.otros"
                                    ></v-textarea>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-text-field
                                        :hide-details="
                                            form.errors?.fecha_solicitud
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.fecha_solicitud
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.fecha_solicitud
                                                ? form.errors?.fecha_solicitud
                                                : ''
                                        "
                                        variant="outlined"
                                        type="date"
                                        label="Fecha Solicitud"
                                        required
                                        density="compact"
                                        v-model="form.fecha_solicitud"
                                    ></v-text-field>
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
                                        label="Fecha Etnrega"
                                        readonly
                                        required
                                        density="compact"
                                        v-model="form.fecha_entrega"
                                    ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-select
                                        :hide-details="
                                            form.errors?.biometrico_id
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.biometrico_id
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.biometrico_id
                                                ? form.errors?.biometrico_id
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Seleccionar Equipo*"
                                        :items="listBiometricos"
                                        item-value="id"
                                        item-title="nombre"
                                        required
                                        density="compact"
                                        v-model="form.biometrico_id"
                                    ></v-select>
                                </v-col>
                                <v-col cols="12" sm="12" md="12" xl="6">
                                    <v-select
                                        :hide-details="
                                            form.errors?.array_repuestos
                                                ? false
                                                : true
                                        "
                                        :error="
                                            form.errors?.array_repuestos
                                                ? true
                                                : false
                                        "
                                        :error-messages="
                                            form.errors?.array_repuestos
                                                ? form.errors?.array_repuestos
                                                : ''
                                        "
                                        variant="outlined"
                                        label="Seleccionar Repuestos*"
                                        :items="listRepuestos"
                                        item-value="id"
                                        item-title="nombre"
                                        multiple
                                        required
                                        density="compact"
                                        v-model="form.array_repuestos"
                                    >
                                        <template
                                            v-slot:selection="{ item, index }"
                                        >
                                            <v-chip v-if="index < 2">
                                                <span>{{ item.title }}</span>
                                            </v-chip>
                                            <span
                                                v-if="index === 2"
                                                class="text-grey text-caption align-self-center"
                                            >
                                                (+{{
                                                    form.array_repuestos
                                                        .length - 2
                                                }}
                                                más)
                                            </span>
                                        </template>
                                    </v-select>
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
                    <span class="text-h5">Cronograma</span>
                </v-card-title>
                <v-card-item class="pa-0">
                    <Cronograma></Cronograma>
                </v-card-item>
            </v-card>
        </v-col>
    </v-row>
</template>
