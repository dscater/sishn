<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Reporte Historial de Mantenimiento",
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
import { useBiometricos } from "@/composables/biometricos/useBiometricos";
const { setLoading } = useApp();

const existe_validacion = ref(false);
const rules = ref([
    (value) => {
        if (value) {
            existe_validacion.value = false;
            return true;
        }
        existe_validacion.value = true;
        return "Debes seleccionar una opción";
    },
]);
const form = ref({
    biometrico_id: null,
});
const formulario = ref(null);

const listBiometricos = ref([]);
const { getBiometricos } = useBiometricos();

const cargarBiometricos = async () => {
    listBiometricos.value = await getBiometricos();
    // listBiometricos.value.unshift({
    //     id: "todos",
    //     nombre: "TODOS",
    // });
};

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte";
});

const generarReporte = async () => {
    const { valid } = await formulario.value.validate();
    if (valid) {
        generando.value = true;
        const url = route("reportes.r_historial_mantenimientos", form.value);
        window.open(url, "_blank");
        setTimeout(() => {
            generando.value = false;
        }, 500);
    }
};

const user = usePage().props.auth.user;
onMounted(() => {
    if (user.tipo != "JEFE DE ÁREA") {
        cargarBiometricos();
    } else {
        form.value.biometrico_id = user.biometrico_area.id;
    }
    setTimeout(() => {
        setLoading(false);
    }, 300);
});
</script>
<template>
    <Head title="Reporte Historial de Mantenimiento"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row>
            <v-col cols="12" sm="12" md="12" xl="8" class="mx-auto">
                <v-card>
                    <v-card-item>
                        <v-container>
                            <v-form
                                @submit.prevent="generarReporte"
                                ref="formulario"
                            >
                                <v-row>
                                    <v-col
                                        cols="12"
                                        v-if="user.tipo != 'JEFE DE ÁREA'"
                                    >
                                        <v-autocomplete
                                            :hide-details="!existe_validacion"
                                            no-data-text="Sin datos"
                                            variant="outlined"
                                            density="compact"
                                            :items="listBiometricos"
                                            item-value="id"
                                            item-title="serie"
                                            label="Equipo Biomédico*"
                                            v-model="form.biometrico_id"
                                            :rules="rules"
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
                                                <span class="text-caption"
                                                    >(
                                                    {{ item.raw.nombre }})</span
                                                >
                                            </template>
                                        </v-autocomplete>
                                    </v-col>
                                    <v-col cols="12">
                                        <v-btn
                                            color="yellow-lighten-1"
                                            block
                                            @click="generarReporte"
                                            :disabled="generando"
                                            v-text="txtBtn"
                                        ></v-btn>
                                    </v-col>
                                </v-row>
                            </v-form>
                        </v-container>
                    </v-card-item>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>
