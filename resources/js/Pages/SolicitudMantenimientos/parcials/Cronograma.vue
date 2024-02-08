<script setup>
import { useSolicitudMantenimientos } from "@/composables/solicitud_mantenimientos/useSolicitudMantenimientos";
import { ref, reactive, onMounted } from "vue";
import FormCronograma from "./FormCronograma.vue";
import FullCalendar from "@fullcalendar/vue3";
import dayGridPlugin from "@fullcalendar/daygrid";
import interactionPlugin from "@fullcalendar/interaction";
import esLocale from "@fullcalendar/core/locales/es";

const { oCronograma, limpiarCronograma, oSolicitudMantenimiento } =
    useSolicitudMantenimientos();
const fullCalendar = ref(null);
let calApi = null;
const accion_dialog = ref(0);
const open_dialog = ref(null);
let index_nuevos = 0;

const actualizarCronograma = async () => {
    if (oCronograma.value.id != 0) {
        // actualizar el cronograma a la solicitud
        const index = oSolicitudMantenimiento.cronogramas.findIndex(
            (e) => e.id + "" === oCronograma.value.id + ""
        );
        if (index !== -1) {
            oSolicitudMantenimiento.cronogramas[index].descripcion =
                oCronograma.value.descripcion;
            oSolicitudMantenimiento.cronogramas[index].date =
                oCronograma.value.date;
            oSolicitudMantenimiento.cronogramas[index].backgroundColor =
                validarFecha(oCronograma.value.date);
        }
    } else {
        // agregar el cronograma a la solicitud
        let id_evento =
            !oCronograma.id || oCronograma.id == ""
                ? "n-" + index_nuevos
                : oCronograma.id;

        oSolicitudMantenimiento.cronogramas.push({
            id: id_evento,
            solicitud_mantenimiento_id: "",
            descripcion: oCronograma.value.descripcion,
            date: oCronograma.value.date,
            backgroundColor: validarFecha(oCronograma.value.date),
            user_id: "",
        });
        index_nuevos++;
    }
    limpiarCronograma();
    open_dialog.value = false;
};

const evento = ref(null);
const eventoEliminado = () => {
    if (!evento.value.event.id.includes("n-")) {
        oSolicitudMantenimiento.eliminados.push(evento.value.event.id);
    }
    const index = oSolicitudMantenimiento.cronogramas.findIndex(
        (e) => e.id + "" === evento.value.event.id + ""
    );
    if (index !== -1) {
        oSolicitudMantenimiento.cronogramas.splice(index, 1);
    }
    calApi.refetchEvents();
    open_dialog.value = false;
    evento.value = null;
    limpiarCronograma();
};

const handleDateClick = (arg) => {
    accion_dialog.value = 0;
    limpiarCronograma();
    oCronograma.value.date = arg.dateStr;
    open_dialog.value = true;
};
const handleEventClick = (arg) => {
    open_dialog.value = true;
    accion_dialog.value = 1;
    oCronograma.value.id = arg.event.id;
    oCronograma.value.solicitud_mantenimiento_id =
        arg.event.extendedProps.solicitud_mantenimiento_id;
    oCronograma.value.descripcion = arg.event.extendedProps.descripcion;
    oCronograma.value.date = arg.event.startStr;
    oCronograma.value.user_id = arg.event.extendedProps.user_id;
    evento.value = arg;
};

function validarFecha(fecha) {
    var fechaActual = new Date();

    var fechaActualCorta = new Date(
        fechaActual.getFullYear(),
        fechaActual.getMonth(),
        fechaActual.getDate()
    );

    var fechaProporcionada = new Date(fecha);
    var fechaProporcionadaCorta = new Date(
        fechaProporcionada.getFullYear(),
        fechaProporcionada.getMonth(),
        fechaProporcionada.getDate()
    );

    if (fechaProporcionadaCorta < fechaActualCorta) {
        return "red";
    } else {
        return "green";
    }
}

const calendarOptions = reactive({
    plugins: [dayGridPlugin, interactionPlugin],
    initialView: "dayGridMonth",
    dateClick: handleDateClick,
    eventClick: handleEventClick,
    events: oSolicitudMantenimiento.cronogramas,
    locale: esLocale,
});

onMounted(() => {
    calApi = fullCalendar.value.getApi();
});
</script>
<template>
    <v-container>
        <v-row class="mt-0">
            <v-col cols="12">
                <FullCalendar :options="calendarOptions" ref="fullCalendar">
                    <template v-slot:eventContent="arg">
                        <b>{{ arg.event.extendedProps.descripcion }}</b>
                    </template>
                </FullCalendar>
            </v-col>
        </v-row>
        <FormCronograma
            :open_dialog="open_dialog"
            :accion_dialog="accion_dialog"
            @envio-formulario="actualizarCronograma"
            @evento-eliminado="eventoEliminado"
            @cerrar-dialog="open_dialog = false"
        ></FormCronograma>
    </v-container>
</template>
