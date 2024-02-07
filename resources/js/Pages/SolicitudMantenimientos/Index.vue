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
import { ref, onMounted } from "vue";
const { mobile, identificaDispositivo, cambiarUrl } = useMenu();
const { setLoading } = useApp();
onMounted(() => {
    identificaDispositivo();
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const { getSolicitudMantenimientosApi, deleteSolicitudMantenimiento } =
    useSolicitudMantenimientos();
const responseSolicitudMantenimientos = ref([]);
const listSolicitudMantenimientos = ref([]);
const itemsPerPage = ref(5);
const headers = ref([
    {
        title: "Código Solicitud",
        align: "start",
        sortable: true,
    },
    { title: "Fecha de Solicitud", align: "start" },
    { title: "Equipo", align: "start" },
    { title: "Repuestos", align: "start" },
    { title: "Nombre Responsable", align: "start" },
    { title: "C.I. Responsable", align: "start" },
    { title: "Nombre Técnico", align: "start" },
    { title: "C.I. Técnico", align: "start" },
    { title: "Tipo Mantenimiento", align: "start" },
    { title: "Motivo Mantenimiento", align: "start" },
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
        responseSolicitudMantenimientos.value =
            await getSolicitudMantenimientosApi(options.value);
        listSolicitudMantenimientos.value =
            responseSolicitudMantenimientos.value.data;
        totalItems.value = parseInt(
            responseSolicitudMantenimientos.value.total
        );
        loading.value = false;
    }, 300);
};
const recargaSolicitudMantenimientos = async () => {
    loading.value = true;
    listSolicitudMantenimientos.value = [];
    options.value.search = search.value;
    responseSolicitudMantenimientos.value = await getSolicitudMantenimientosApi(
        options.value
    );
    listSolicitudMantenimientos.value =
        responseSolicitudMantenimientos.value.data;
    totalItems.value = parseInt(responseSolicitudMantenimientos.value.total);
    setTimeout(() => {
        loading.value = false;
    }, 300);
};

const editarSolicitudMantenimiento = (item) => {
    cambiarUrl(route("solicitud_mantenimientos.edit", item.id));
};

const eliminarSolicitudMantenimiento = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.codigo}</strong>`,
        showCancelButton: true,
        confirmButtonColor: "#B61431",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await deleteSolicitudMantenimiento(item.id);
            if (respuesta && respuesta.sw) {
                recargaSolicitudMantenimientos();
            }
        }
    });
};
</script>
<template>
    <Head title="Solicitud de Mantenimiento"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row class="mt-0">
            <v-col cols="12" class="d-flex justify-end">
                <v-btn
                    color="yellow-lighten-1"
                    prepend-icon="mdi-plus"
                    @click="
                        cambiarUrl(route('solicitud_mantenimientos.create'))
                    "
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
                            <v-col cols="12" sm="6" md="4">
                                Solicitud de Mantenimiento
                            </v-col>
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
                            :items="listSolicitudMantenimientos"
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
                                        <td>{{ item.codigo }}</td>
                                        <td>{{ item.fecha_solicitud_t }}</td>
                                        <td>{{ item.biometrico.nombre }}</td>
                                        <td>{{ item.repuestos_txt }}</td>
                                        <td>{{ item.nombre_responsable }}</td>
                                        <td>{{ item.ci_responsable }}</td>
                                        <td>{{ item.nombre_tecnico }}</td>
                                        <td>{{ item.ci_tecnico }}</td>
                                        <td>{{ item.tipo_mantenimiento }}</td>
                                        <td>{{ item.motivo_mantenimiento }}</td>
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
                                                @click="
                                                    editarSolicitudMantenimiento(
                                                        item
                                                    )
                                                "
                                                icon="mdi-pencil"
                                            ></v-btn>
                                            <v-btn
                                                color="error"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="
                                                    eliminarSolicitudMantenimiento(
                                                        item
                                                    )
                                                "
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
                                                            >Diagnostico</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.diagnostico
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
                                                            >Otros</v-col
                                                        >
                                                        <v-col cols="12">{{
                                                            item.otros
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
                                                    data-label="Código"
                                                >
                                                    {{ item.codigo }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Fecha de Solicitud"
                                                >
                                                    {{ item.fecha_solicitud_t }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Equipo"
                                                >
                                                    {{ item.biometrico.nombre }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Repuestos"
                                                >
                                                    {{ item.repuestos_txt }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Nombre Responsable"
                                                >
                                                    {{
                                                        item.nombre_responsable
                                                    }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="C.I. Responsable"
                                                >
                                                    {{ item.ci_responsable }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Nombre Técnico"
                                                >
                                                    {{ item.nombre_tecnico }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="C.I. Técnico"
                                                >
                                                    {{ item.ci_tecnico }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Tipo de Mantenimiento"
                                                >
                                                    {{
                                                        item.tipo_mantenimiento
                                                    }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Diagnostico"
                                                >
                                                    {{ item.diagnostico }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Otros"
                                                >
                                                    {{ item.otros }}
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
                                                            editarSolicitudMantenimiento(
                                                                item
                                                            )
                                                        "
                                                        icon="mdi-pencil"
                                                    ></v-btn>
                                                    <v-btn
                                                        color="error"
                                                        size="small"
                                                        class="pa-1 ma-1"
                                                        @click="
                                                            eliminarSolicitudMantenimiento(
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
