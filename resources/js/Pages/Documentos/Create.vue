<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Documentos",
        disabled: false,
        url: route("documentos.index"),
        name_url: "documentos.index",
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
import { onMounted } from "vue";
import { useMenu } from "@/composables/useMenu";
import { useDocumentos } from "@/composables/documentos/useDocumentos";
import Formulario from "./parcials/Formulario.vue";
const { mobile, identificaDispositivo } = useMenu();
const { setLoading } = useApp();
const { oDocumento, limpiarDocumento } = useDocumentos();
limpiarDocumento();
onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});
</script>
<template>
    <Head title="Documentos"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row class="mt-0">
            <v-col cols="12" sm="12" md="12">
                <Formulario></Formulario>
            </v-col>
        </v-row>
    </v-container>
</template>
