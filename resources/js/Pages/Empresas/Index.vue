<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Empresas",
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
import { useEmpresas } from "@/composables/empresas/useEmpresas";
import { ref, onMounted } from "vue";
import { useMenu } from "@/composables/useMenu";
import Formulario from "./Formulario.vue";
const { mobile, identificaDispositivo } = useMenu();
const { setLoading } = useApp();
onMounted(() => {
    identificaDispositivo();
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const { getEmpresasApi, setEmpresa, limpiarEmpresa, deleteEmpresa } =
    useEmpresas();
const responseEmpresas = ref([]);
const listEmpresas = ref([]);
const itemsPerPage = ref(5);
const headers = ref([
    {
        title: "Id",
        align: "start",
        sortable: false,
    },
    { title: "Nombre Empresa", align: "start", sortable: false },
    { title: "Nit", align: "start", sortable: false },
    { title: "Teléfono", align: "start", sortable: false },
    {
        title: "Fecha Inicio",

        align: "start",
        sortable: false,
    },
    { title: "Fecha Fin", align: "start", sortable: false },
    { title: "Correo", align: "start", sortable: false },
    { title: "Dirección", align: "start", sortable: false },
    { title: "País", align: "start", sortable: false },
    { title: "Logo", align: "start", sortable: false },
    {
        title: "Fecha Registro",

        align: "start",
        sortable: false,
    },
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
        responseEmpresas.value = await getEmpresasApi(options.value);
        listEmpresas.value = responseEmpresas.value.data;
        totalItems.value = parseInt(responseEmpresas.value.total);
        loading.value = false;
    }, 300);
};
const recargaEmpresas = async () => {
    loading.value = true;
    listEmpresas.value = [];
    options.value.search = search.value;
    responseEmpresas.value = await getEmpresasApi(options.value);
    listEmpresas.value = responseEmpresas.value.data;
    totalItems.value = parseInt(responseEmpresas.value.total);
    setTimeout(() => {
        loading.value = false;
        open_dialog.value = false;
    }, 300);
};
const accion_dialog = ref(0);
const open_dialog = ref(false);
const agregarRegistro = () => {
    limpiarEmpresa();
    accion_dialog.value = 0;
    open_dialog.value = true;
};
const editarEmpresa = (item) => {
    setEmpresa(item);
    accion_dialog.value = 1;
    open_dialog.value = true;
};
const eliminarEmpresa = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.nombre}</strong>`,
        showCancelButton: true,
        confirmButtonColor: "#B61431",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await deleteEmpresa(item.id);
            if (respuesta && respuesta.sw) {
                recargaEmpresas();
            }
        }
    });
};
</script>
<template>
    <Head title="Empresas"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row class="mt-0">
            <v-col cols="12" class="d-flex justify-end">
                <v-btn
                    color="yellow-lighten-1"
                    prepend-icon="mdi-plus"
                    @click="agregarRegistro"
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
                            <v-col cols="12" sm="6" md="4"> Empresas </v-col>
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
                            :items="listEmpresas"
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
                                <tr v-if="!mobile">
                                    <td>{{ item.id }}</td>
                                    <td>{{ item.nombre }}</td>
                                    <td>{{ item.nit }}</td>
                                    <td>{{ item.fono }}</td>
                                    <td>{{ item.fecha_ini_t }}</td>
                                    <td>{{ item.fecha_fin_t }}</td>
                                    <td>{{ item.correo }}</td>
                                    <td>{{ item.dir }}</td>
                                    <td>{{ item.pais }}</td>
                                    <td>
                                        <v-card
                                            class="my-2"
                                            elevation="2"
                                            rounded
                                            v-if="item.url_logo"
                                        >
                                            <v-img
                                                :src="item.url_logo"
                                                height="64"
                                                cover
                                            ></v-img>
                                        </v-card>
                                        <v-avatar
                                            v-else
                                            color="yellow-lighten-1"
                                            size="45"
                                        >
                                            <span class="text-body-1">{{
                                                item.iniciales_nombre
                                            }}</span>
                                        </v-avatar>
                                    </td>
                                    <td>{{ item.fecha_registro_t }}</td>
                                    <td class="text-right">
                                        <v-btn
                                            color="yellow"
                                            size="small"
                                            class="pa-1 ma-1"
                                            @click="editarEmpresa(item)"
                                            icon="mdi-pencil"
                                        ></v-btn>
                                        <v-btn
                                            color="error"
                                            size="small"
                                            class="pa-1 ma-1"
                                            @click="eliminarEmpresa(item)"
                                            icon="mdi-trash-can"
                                        ></v-btn>
                                    </td>
                                </tr>
                                <tr v-else>
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
                                                data-label="Nombre Empresa"
                                            >
                                                {{ item.nombre }}
                                            </li>
                                            <li
                                                class="flex-item"
                                                data-label="Nit"
                                            >
                                                {{ item.nit }}
                                            </li>
                                            <li
                                                class="flex-item"
                                                data-label="Teléfono"
                                            >
                                                {{ item.fono }}
                                            </li>
                                            <li
                                                class="flex-item"
                                                data-label="Fecha Inicio"
                                            >
                                                {{ item.fecha_ini_t }}
                                            </li>
                                            <li
                                                class="flex-item"
                                                data-label="Fecha Fin"
                                            >
                                                {{ item.fecha_fin_t }}
                                            </li>
                                            <li
                                                class="flex-item"
                                                data-label="Correo"
                                            >
                                                {{ item.correo }}
                                            </li>
                                            <li
                                                class="flex-item"
                                                data-label="Dirección"
                                            >
                                                {{ item.dir }}
                                            </li>
                                            <li
                                                class="flex-item"
                                                data-label="País"
                                            >
                                                {{ item.pais }}
                                            </li>
                                            <li
                                                class="flex-item"
                                                data-label="Logo"
                                            >
                                                <v-card
                                                    class="my-2"
                                                    elevation="2"
                                                    rounded
                                                    v-if="item.url_logo"
                                                    width="120"
                                                >
                                                    <v-img
                                                        :src="item.url_logo"
                                                        height="64"
                                                        cover
                                                    ></v-img>
                                                </v-card>
                                                <v-avatar
                                                    v-else
                                                    color="yellow-lighten-1"
                                                    size="45"
                                                >
                                                    <span class="text-body-1">{{
                                                        item.iniciales_nombre
                                                    }}</span>
                                                </v-avatar>
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
                                                    @click="editarEmpresa(item)"
                                                    icon="mdi-pencil"
                                                ></v-btn>
                                                <v-btn
                                                    color="error"
                                                    size="small"
                                                    class="pa-1 ma-1"
                                                    @click="
                                                        eliminarEmpresa(item)
                                                    "
                                                    icon="mdi-trash-can"
                                                ></v-btn>
                                            </v-col>
                                        </v-row>
                                    </td>
                                </tr>
                            </template>
                        </v-data-table-server>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
        <Formulario
            :open_dialog="open_dialog"
            :accion_dialog="accion_dialog"
            @envio-formulario="recargaEmpresas"
            @cerrar-dialog="open_dialog = false"
        ></Formulario>
    </v-container>
</template>
