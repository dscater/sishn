<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Servicios",
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
import { useServicios } from "@/composables/servicios/useServicios";
import { ref, onMounted } from "vue";
const { mobile, identificaDispositivo, cambiarUrl } = useMenu();
const { setLoading } = useApp();
onMounted(() => {
    identificaDispositivo();
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const { getServiciosApi, deleteServicio } = useServicios();
const responseServicios = ref([]);
const listServicios = ref([]);
const itemsPerPage = ref(5);
const headers = ref([
    {
        title: "Id",
        align: "start",
        sortable: true,
    },
    {
        title: "Código Solicitud",
        align: "start",
        sortable: true,
    },
    { title: "Fecha de Entrega", align: "start" },
    { title: "Procedimientos", align: "start" },
    { title: "Observaciones", align: "start" },
    { title: "Diagnostico Previo", align: "start" },
    { title: "Estado del Equipo", align: "start" },
    { title: "Trabajo Realizado", align: "start" },
    { title: "Más", align: "start" },
    { title: "Acción", align: "end", sortable: false },
]);

const search = ref("");
const options = ref({
    page: 1,
    itemsPerPage: itemsPerPage,
    sortBy: "",
    sortOrder: "desc",
    search: "",
});

const loading = ref(true);
const totalItems = ref(0);
let setTimeOutLoadData = null;
const loadItems = async ({ page, itemsPerPage, sortBy }) => {
    loading.value = true;
    options.value.page = page;
    if (sortBy.length > 0) {
        options.value.sortBy = sortBy[0].key;
        options.value.sortOrder = sortBy[0].order;
    }
    options.value.search = search.value;

    clearInterval(setTimeOutLoadData);
    setTimeOutLoadData = setTimeout(async () => {
        responseServicios.value = await getServiciosApi(options.value);
        listServicios.value = responseServicios.value.data;
        totalItems.value = parseInt(responseServicios.value.total);
        loading.value = false;
    }, 300);
};
const recargaServicios = async () => {
    loading.value = true;
    listServicios.value = [];
    options.value.search = search.value;
    responseServicios.value = await getServiciosApi(options.value);
    listServicios.value = responseServicios.value.data;
    totalItems.value = parseInt(responseServicios.value.total);
    setTimeout(() => {
        loading.value = false;
    }, 300);
};

const editarServicio = (item) => {
    cambiarUrl(route("servicios.edit", item.id));
};

const eliminarServicio = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `Id: <strong>${item.id}</strong>`,
        showCancelButton: true,
        confirmButtonColor: "#B61431",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await deleteServicio(item.id);
            if (respuesta && respuesta.sw) {
                recargaServicios();
            }
        }
    });
};
</script>
<template>
    <Head title="Servicios"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row class="mt-0">
            <v-col cols="12" class="d-flex justify-end">
                <v-btn
                    color="yellow-lighten-1"
                    prepend-icon="mdi-plus"
                    @click="cambiarUrl(route('servicios.create'))"
                >
                    Agregar</v-btn
                >
            </v-col>
        </v-row>
        <v-row class="mt-0">
            <v-col cols="12">
                <v-card flat>
                    <v-card-title>
                        <v-row
                            class="bg-grey-darken-3 d-flex align-center pa-3"
                        >
                            <v-col cols="12" sm="6" md="4"> Servicios </v-col>
                            <v-col cols="12" sm="6" md="4" offset-md="4">
                                <v-text-field
                                    v-model="search"
                                    label="Buscar"
                                    append-inner-icon="mdi-magnify"
                                    variant="underlined"
                                    clearable
                                    hide-details
                                ></v-text-field>
                            </v-col>
                        </v-row>
                    </v-card-title>
                    <v-card-text>
                        <v-data-table-server
                            v-model:items-per-page="itemsPerPage"
                            :headers="!mobile ? headers : []"
                            :class="[mobile ? 'mobile' : '']"
                            :items-length="totalItems"
                            :items="listServicios"
                            :loading="loading"
                            :search="search"
                            @update:options="loadItems"
                            height="auto"
                            no-data-text="No se encontrarón registros"
                            loading-text="Cargando..."
                            page-text="{0} - {1} de {2}"
                            items-per-page-text="Registros por página"
                            :items-per-page-options="[
                                { value: 10, title: '10' },
                                { value: 25, title: '25' },
                                { value: 50, title: '50' },
                                { value: 100, title: '100' },
                                {
                                    value: -1,
                                    title: 'Todos',
                                },
                            ]"
                        >
                            <template v-slot:item="{ item }">
                                <template v-if="!mobile">
                                    <tr>
                                        <td>{{ item.id }}</td>
                                        <td>
                                            {{
                                                item.solicitud_mantenimiento
                                                    .codigo
                                            }}
                                        </td>
                                        <td>{{ item.fecha_entrega_t }}</td>
                                        <td>{{ item.procedimientos }}</td>
                                        <td>{{ item.observaciones }}</td>
                                        <td>{{ item.diagnostico_previo }}</td>
                                        <td>{{ item.estado_equipo }}</td>
                                        <td>{{ item.trabajo_realizado }}</td>
                                        <td>
                                            <v-btn
                                                :icon="
                                                    item.mas
                                                        ? 'mdi-chevron-down'
                                                        : 'mdi-chevron-left'
                                                "
                                                @click="item.mas = !item.mas"
                                            ></v-btn>
                                        </td>
                                        <td class="text-right">
                                            <v-btn
                                                color="yellow"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="editarServicio(item)"
                                                icon="mdi-pencil"
                                            ></v-btn>
                                            <v-btn
                                                color="error"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="eliminarServicio(item)"
                                                icon="mdi-trash-can"
                                            ></v-btn>
                                        </td>
                                    </tr>
                                    <tr v-if="item.mas">
                                        <td
                                            :colspan="headers.length"
                                            class="py-5"
                                        >
                                            <v-row>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Capacitación</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.capacitacion
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Descripción</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.descripcion
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Fecha Inicio -
                                                            Fecha Fin</v-col
                                                        >
                                                        <v-col cols="12"
                                                            >{{
                                                                item.fecha_ini_t
                                                            }}
                                                            -
                                                            {{
                                                                item.fecha_fin_t
                                                            }}</v-col
                                                        >
                                                    </v-row>
                                                </v-col>
                                                <v-col
                                                    cols="3"
                                                    class="text-center"
                                                >
                                                    <v-row>
                                                        <v-col
                                                            cols="12"
                                                            class="pb-0 text-caption font-weight-black"
                                                            >Fecha de
                                                            Registro</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.fecha_registro_t
                                                        }}</v-col>
                                                    </v-row>
                                                </v-col>
                                            </v-row>
                                        </td>
                                    </tr>
                                </template>
                                <template v-else>
                                    <tr>
                                        <td>
                                            <ul class="flex-content">
                                                <li
                                                    class="flex-item"
                                                    data-label="Id"
                                                >
                                                    {{ item.id }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Código de Solicitud"
                                                >
                                                    {{
                                                        item
                                                            .solicitud_mantenimiento
                                                            .codigo
                                                    }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Fecha de entrega"
                                                >
                                                    {{ item.fecha_entrega_t }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Procedimientos"
                                                >
                                                    {{ item.procedimientos }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Observaciones"
                                                >
                                                    {{ item.observaciones }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Diagnóstico Previo"
                                                >
                                                    {{
                                                        item.diagnostico_equipo
                                                    }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Estado del equipo"
                                                >
                                                    {{ item.estado_equipo }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Trabajo realizado"
                                                >
                                                    {{ item.trabajo_realizado }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Capacitación"
                                                >
                                                    {{ item.capacitacion }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Descripción"
                                                >
                                                    {{ item.descripcion }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Fecha Inicio - Fecha Fin"
                                                >
                                                    {{ item.fecha_ini_t }} -
                                                    {{ item.fecha_fin_t }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Fecha Registro"
                                                >
                                                    {{ item.fecha_registro_t }}
                                                </li>
                                            </ul>
                                            <v-row>
                                                <v-col
                                                    cols="12"
                                                    class="text-center pa-5"
                                                >
                                                    <v-btn
                                                        color="yellow"
                                                        size="small"
                                                        class="pa-1 ma-1"
                                                        @click="
                                                            editarServicio(item)
                                                        "
                                                        icon="mdi-pencil"
                                                    ></v-btn>
                                                    <v-btn
                                                        color="error"
                                                        size="small"
                                                        class="pa-1 ma-1"
                                                        @click="
                                                            eliminarServicio(
                                                                item
                                                            )
                                                        "
                                                        icon="mdi-trash-can"
                                                    ></v-btn>
                                                </v-col>
                                            </v-row>
                                        </td>
                                    </tr>
                                </template>
                            </template>
                        </v-data-table-server>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>
