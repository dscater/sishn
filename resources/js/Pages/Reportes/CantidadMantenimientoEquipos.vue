<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Reporte Cantidad de Mantenimientos Equipos",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>

<script setup>
import BreadBrums from "@/Components/BreadBrums.vue";
import { useApp } from "@/composables/useApp";
import { computed, onMounted, ref } from "vue";
import { Head, usePage } from "@inertiajs/vue3";
import { useUnidadAreas } from "@/composables/unidad_areas/useUnidadAreas";
import { useBiometricos } from "@/composables/biometricos/useBiometricos";
import Highcharts from "highcharts";
import exporting from "highcharts/modules/exporting";
exporting(Highcharts);
Highcharts.setOptions({
    lang: {
        downloadPNG: "Descargar PNG",
        downloadJPEG: "Descargar JPEG",
        downloadPDF: "Descargar PDF",
        downloadSVG: "Descargar SVG",
        printChart: "Imprimir gráfico",
        contextButtonTitle: "Menú de exportación",
        viewFullscreen: "Pantalla completa",
        exitFullscreen: "Salir de pantalla completa",
    },
});

const { setLoading } = useApp();
const { getUnidadAreas } = useUnidadAreas();
const { getBiometricosByArea } = useBiometricos();

const form = ref({
    unidad_area_id: "todos",
    biometrico_id: "todos",
});
const listUnidadAreas = ref([]);
const listBiometricos = ref([]);

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte";
});

const generarReporte = async () => {
    generando.value = true;

    axios
        .get(route("reportes.r_cantidad_mantenimiento_equipos"), {
            params: form.value,
        })
        .then((response) => {
            generando.value = false;
            // Create the chart
            Highcharts.chart("container", {
                chart: {
                    type: "column",
                },
                title: {
                    align: "center",
                    text: "Cantidad de Mantenimiento de cada Equipo por Área",
                },
                subtitle: {
                    align: "left",
                    text: "",
                },
                accessibility: {
                    announceNewData: {
                        enabled: true,
                    },
                },
                xAxis: {
                    type: "category",
                },
                yAxis: {
                    title: {
                        text: "Total",
                    },
                },
                legend: {
                    enabled: true,
                },
                plotOptions: {
                    series: {
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            format: "{point.y:.0f}",
                        },
                    },
                },

                tooltip: {
                    headerFormat:
                        '<span style="font-size:11px">{series.name}</span><br>',
                    pointFormat:
                        '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.0f}</b><br/>',
                },

                series: response.data.data,
            });
        })
        .catch((err) => {
            generando.value = false;
            console.log(err);
        });
};

const cambiaArea = async (val) => {
    listBiometricos.value = [];
    form.biometrico_id = "todos";
    if (val != "todos") {
        listBiometricos.value = await getBiometricosByArea({
            id: val,
        });

        if (listBiometricos.value.length > 0) {
            listBiometricos.value.unshift({
                id: "todos",
                nombre: "",
                serie: "TODOS",
            });
        }
    }
};

const cargarListas = async () => {
    listUnidadAreas.value = await getUnidadAreas({
        order: "desc",
    });

    listUnidadAreas.value.unshift({
        id: "todos",
        nombre: "TODOS",
        codigo: "",
    });
};

onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
    cargarListas();
});
</script>
<template>
    <Head title="Reporte Cantidad de Mantenimientos Equipos"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row>
            <v-col cols="12" sm="12" md="12" xl="8" class="mx-auto">
                <v-card>
                    <v-card-item>
                        <v-container>
                            <form @submit.prevent="generarReporte">
                                <v-row>
                                    <v-col cols="12">
                                        <v-autocomplete
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
                                                    ? form.errors
                                                          ?.unidad_area_id
                                                    : ''
                                            "
                                            variant="outlined"
                                            density="compact"
                                            required
                                            :items="listUnidadAreas"
                                            item-value="id"
                                            item-title="nombre"
                                            label="Seleccionar área*"
                                            v-model="form.unidad_area_id"
                                            @update:modelValue="cambiaArea"
                                        >
                                            <template
                                                v-slot:item="{ props, item }"
                                            >
                                                <v-list-item
                                                    v-bind="props"
                                                    :subtitle="item.raw.codigo"
                                                ></v-list-item>
                                            </template>
                                            <template
                                                v-slot:selection="{ item }"
                                            >
                                                <span>{{
                                                    item.raw.nombre
                                                }}</span>
                                            </template></v-autocomplete
                                        >
                                    </v-col>
                                    <v-col
                                        cols="12"
                                        v-if="form.unidad_area_id != 'todos'"
                                    >
                                        <v-autocomplete
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
                                            no-data-text="Sin registros"
                                            variant="outlined"
                                            density="compact"
                                            required
                                            :items="listBiometricos"
                                            item-value="id"
                                            item-title="serie"
                                            label="Seleccionar Equipo*"
                                            v-model="form.biometrico_id"
                                        >
                                            <template
                                                v-slot:item="{ props, item }"
                                            >
                                                <v-list-item
                                                    v-bind="props"
                                                    :subtitle="item.raw.nombre"
                                                ></v-list-item>
                                            </template>
                                            <template
                                                v-slot:selection="{ item }"
                                            >
                                                <span>{{ item.raw.serie }}</span
                                                >&nbsp;
                                                <span
                                                    class="text-caption"
                                                    v-if="item.raw.nombre != ''"
                                                    >(
                                                    {{ item.raw.nombre }})</span
                                                >
                                            </template>
                                        </v-autocomplete>
                                    </v-col>
                                    <v-col
                                        cols="12"
                                        v-if="listUnidadAreas.length > 0"
                                    >
                                        <v-btn
                                            class="bg-indigo-darken-4"
                                            block
                                            @click="generarReporte"
                                            :disabled="generando"
                                            v-text="txtBtn"
                                        ></v-btn>
                                    </v-col>
                                </v-row>
                            </form>
                        </v-container>
                    </v-card-item>
                </v-card>
            </v-col>
            <v-col cols="12">
                <div id="container"></div>
            </v-col>
        </v-row>
    </v-container>
</template>
