<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Reporte Solicitud de Mantenimiento",
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
import { useSolicitudMantenimientos } from "@/composables/solicitud_mantenimientos/useSolicitudMantenimientos";
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
    unidad_area_id: null,
    solicitud_mantenimiento_id: null,
});
const formulario = ref(null);

const listSolicitudMantenimientos = ref([]);
const listUnidadAreas = ref([]);
const { getUnidadAreas } = useUnidadAreas();
const { getSolicitudMantenimientoByUnidadAreaId } =
    useSolicitudMantenimientos();

const cargarUnidadAreas = async () => {
    listUnidadAreas.value = await getUnidadAreas();
};

const updateSelectUnidadArea = (value) => {
    listSolicitudMantenimientos.value = [];
    form.value.solicitud_mantenimiento_id = null;
    cargarSolicitudMantenimientos(value);
};

const cargarSolicitudMantenimientos = async (id) => {
    listSolicitudMantenimientos.value =
        await getSolicitudMantenimientoByUnidadAreaId(id, "desc");
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
        const url = route("reportes.r_solicitud_mantenimiento", form.value);
        window.open(url, "_blank");
        setTimeout(() => {
            generando.value = false;
        }, 500);
    }
};

const user = usePage().props.auth.user;
onMounted(() => {
    if (user.tipo != "JEFE DE ÁREA") {
        cargarUnidadAreas();
    } else {
        form.value.unidad_area_id = user.unidad_area.id;
        cargarSolicitudMantenimientos(user.unidad_area.id);
    }
    setTimeout(() => {
        setLoading(false);
    }, 300);
});
</script>
<template>
    <Head title="Reporte Solicitud de Mantenimiento"></Head>
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
                                        <v-select
                                            :hide-details="!existe_validacion"
                                            no-data-text="Sin datos"
                                            variant="outlined"
                                            density="compact"
                                            :items="listUnidadAreas"
                                            item-value="id"
                                            item-title="nombre"
                                            label="Unidad/Área*"
                                            v-model="form.unidad_area_id"
                                            @update:model-value="
                                                updateSelectUnidadArea
                                            "
                                            :rules="rules"
                                        ></v-select>
                                    </v-col>

                                    <v-col cols="12">
                                        <v-select
                                            :hide-details="!existe_validacion"
                                            no-data-text="Sin datos"
                                            variant="outlined"
                                            density="compact"
                                            :items="listSolicitudMantenimientos"
                                            item-value="id"
                                            item-title="codigo"
                                            label="Código Solicitud de Mantenimiento*"
                                            v-model="
                                                form.solicitud_mantenimiento_id
                                            "
                                            :rules="rules"
                                        ></v-select>
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
