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
        title: "Nuevo",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import BreadBrums from "@/Components/BreadBrums.vue";
import { useApp } from "@/composables/useApp";
import { Head } from "@inertiajs/vue3";
import { onMounted, defineProps } from "vue";
import Formulario from "./parcials/Formulario.vue";
import { useSolicitudMantenimientos } from "@/composables/solicitud_mantenimientos/useSolicitudMantenimientos";
const { setLoading } = useApp();

const props = defineProps({
    solicitud_mantenimiento: {
        type: Object,
        default: null,
    },
});

const { setSolicitudMantenimiento, oSolicitudMantenimiento } =
    useSolicitudMantenimientos();
setSolicitudMantenimiento(props.solicitud_mantenimiento);

onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});
</script>
<template>
    <Head title="Solicitud de Mantenimientos"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row class="mt-0">
            <v-col cols="12" sm="12" md="12">
                <Formulario></Formulario>
            </v-col>
        </v-row>
    </v-container>
</template>
