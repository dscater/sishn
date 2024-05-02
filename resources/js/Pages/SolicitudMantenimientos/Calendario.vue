<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Solicitud de Mantenimiento",
        disabled: false,
        url: route("solicitud_mantenimientos.index"),
        name_url: "solicitud_mantenimientos.index",
    },
    {
        title: "Cronogramas",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import BreadBrums from "@/Components/BreadBrums.vue";
import { useApp } from "@/composables/useApp";
import { useMenu } from "@/composables/useMenu";
import { Head } from "@inertiajs/vue3";
import { useSolicitudMantenimientos } from "@/composables/solicitud_mantenimientos/useSolicitudMantenimientos";
import { ref, reactive, onMounted } from "vue";
import FullCalendar from "@fullcalendar/vue3";
import dayGridPlugin from "@fullcalendar/daygrid";
import interactionPlugin from "@fullcalendar/interaction";
import esLocale from "@fullcalendar/core/locales/es";
import axios from "axios";

const { mobile, identificaDispositivo, cambiarUrl } = useMenu();
const { setLoading } = useApp();
const { getSolicitudMantenimientosApi, deleteSolicitudMantenimiento } =
    useSolicitudMantenimientos();

const dialog = ref(false);
let cronograma = ref(null);
const handleEventClick = (arg) => {
    cronograma = {
        id: arg.event.id,
        fecha: arg.event.extendedProps.date_t,
        descripcion: arg.event.extendedProps.descripcion,
        backgroundColor: arg.event.backgroundColor,
        solicitud_mantenimiento:
            arg.event.extendedProps.solicitud_mantenimiento,
    };
    dialog.value = true;
};

const getCronogramas = () => {
    axios.get(route("cronogramas.listado")).then((response) => {
        calendarOptions.events = response.data.cronogramas;
    });
};
const calendarOptions = reactive({
    plugins: [dayGridPlugin, interactionPlugin],
    initialView: "dayGridMonth",
    eventClick: handleEventClick,
    events: [],
    locale: esLocale,
});

onMounted(() => {
    identificaDispositivo();
    getCronogramas();
    setTimeout(() => {
        setLoading(false);
    }, 300);
});
</script>
<template>
    <Head title="Solicitud de Mantenimiento"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row class="mt-0">
            <v-col cols="12" class="d-flex justify-end">
                <v-btn
                    prepend-icon="mdi-arrow-left"
                    @click="cambiarUrl(route('solicitud_mantenimientos.index'))"
                >
                    Volver</v-btn
                >
            </v-col>
        </v-row>
        <v-row class="mt-0">
            <v-col cols="12" sm="12" md="10" xl="8" class="mx-auto">
                <v-card flat>
                    <v-card-title>
                        <v-row
                            class="bg-grey-darken-3 d-flex align-center pa-3"
                        >
                            <v-col cols="12" sm="6" md="4"> Cronograma </v-col>
                        </v-row>
                    </v-card-title>
                    <v-card-text>
                        <v-container>
                            <v-row>
                                <v-col cols="12">
                                    <FullCalendar
                                        :options="calendarOptions"
                                        ref="fullCalendar"
                                    >
                                        <template v-slot:eventContent="arg">
                                            <b>{{
                                                arg.event.extendedProps
                                                    .descripcion
                                            }}</b>
                                        </template>
                                    </FullCalendar>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
        <v-dialog v-model="dialog" width="1024" scrollable>
            <v-card>
                <v-card-title class="bg-yellow-lighten-1 pa-4"
                    ><span class="text-h5"
                        >Cronograma: {{ cronograma.fecha }}</span
                    ></v-card-title
                >
                <v-card-item>
                    <v-row>
                        <v-col cols="12">
                            <v-row
                                class="d-flex align-center pa-3 mb-0"
                                :style="
                                    'background-color:' +
                                    cronograma.backgroundColor +
                                    ';color:white'
                                "
                            >
                                <v-col cols="12" class="text-center">{{
                                    cronograma.descripcion
                                }}</v-col>
                            </v-row>
                            <v-row>
                                <v-col
                                    cols="4"
                                    class="text-body-2 font-weight-black text-right"
                                    >Unidad/Área:
                                </v-col>
                                <v-col cols="8">{{
                                    cronograma.solicitud_mantenimiento
                                        .biometrico.unidad_area.nombre
                                }}</v-col>
                            </v-row>
                            <v-row>
                                <v-col
                                    cols="4"
                                    class="text-body-2 font-weight-black text-right"
                                    >Equipo:
                                </v-col>
                                <v-col cols="8">
                                    <v-row>
                                        <v-col cols="12" class="pb-0">{{
                                            cronograma.solicitud_mantenimiento
                                                .biometrico.nombre
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
                                                    cronograma
                                                        .solicitud_mantenimiento
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
                                                    cronograma
                                                        .solicitud_mantenimiento
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
                                                    cronograma
                                                        .solicitud_mantenimiento
                                                        .biometrico.serie
                                                }}</v-chip
                                            >
                                        </v-col>
                                    </v-row>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col
                                    cols="4"
                                    class="text-body-2 font-weight-black text-right"
                                    >Nombre Responsable:
                                </v-col>
                                <v-col cols="8">{{
                                    cronograma.solicitud_mantenimiento
                                        .responsable.full_name
                                }}</v-col>
                            </v-row>
                            <v-row>
                                <v-col
                                    cols="4"
                                    class="text-body-2 font-weight-black text-right"
                                    >C.I. Responsable:
                                </v-col>
                                <v-col cols="8">{{
                                    cronograma.solicitud_mantenimiento
                                        .responsable.full_ci
                                }}</v-col>
                            </v-row>
                            <v-row>
                                <v-col
                                    cols="4"
                                    class="text-body-2 font-weight-black text-right"
                                    >Nombre Técnico:
                                </v-col>
                                <v-col cols="8">{{
                                    cronograma.solicitud_mantenimiento.tecnico
                                        .full_name
                                }}</v-col>
                            </v-row>
                            <v-row>
                                <v-col
                                    cols="4"
                                    class="text-body-2 font-weight-black text-right"
                                    >C.I. Técnico:
                                </v-col>
                                <v-col cols="8">{{
                                    cronograma.solicitud_mantenimiento.tecnico
                                        .full_ci
                                }}</v-col>
                            </v-row>
                            <v-row>
                                <v-col
                                    cols="4"
                                    class="text-body-2 font-weight-black text-right"
                                    >Motivo Mantenimiento:
                                </v-col>
                                <v-col cols="8">{{
                                    cronograma.solicitud_mantenimiento
                                        .motivo_mantenimiento
                                }}</v-col>
                            </v-row>
                            <v-row>
                                <v-col
                                    cols="4"
                                    class="text-body-2 font-weight-black text-right"
                                    >Diagnostico:
                                </v-col>
                                <v-col cols="8">{{
                                    cronograma.solicitud_mantenimiento
                                        .diagnostico
                                }}</v-col>
                            </v-row>
                            <br />
                        </v-col>
                    </v-row>
                </v-card-item>
                <v-card-actions class="border-t">
                    <v-spacer></v-spacer>
                    <v-btn
                        color="grey-darken-4"
                        variant="text"
                        @click="dialog = false"
                    >
                        Cerrar
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-container>
</template>
