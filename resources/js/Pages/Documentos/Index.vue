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
import { useDocumentos } from "@/composables/documentos/useDocumentos";
import { ref, onMounted } from "vue";
import VerArchivos from "./VerArchivos.vue";

const { mobile, identificaDispositivo, cambiarUrl } = useMenu();
const { setLoading } = useApp();
onMounted(() => {
    identificaDispositivo();
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const { getDocumentosApi, deleteDocumento, setDocumento } = useDocumentos();
const responseDocumentos = ref([]);
const listDocumentos = ref([]);
const itemsPerPage = ref(5);
const headers = ref([
    {
        title: "Id",
        align: "start",
        sortable: false,
    },
    {
        title: "Descripción",
        align: "start",
        sortable: false,
    },
    {
        title: "Total Archivos",
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

const accion_dialog = ref(0);
const open_dialog = ref(false);

const verArchivos = (item) => {
    setDocumento(item, true);
    accion_dialog.value = 0;
    open_dialog.value = true;
};

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
        responseDocumentos.value = await getDocumentosApi(options.value);
        listDocumentos.value = responseDocumentos.value.data;
        totalItems.value = parseInt(responseDocumentos.value.total);
        loading.value = false;
    }, 300);
};
const recargaDocumentos = async () => {
    loading.value = true;
    listDocumentos.value = [];
    options.value.search = search.value;
    responseDocumentos.value = await getDocumentosApi(options.value);
    listDocumentos.value = responseDocumentos.value.data;
    totalItems.value = parseInt(responseDocumentos.value.total);
    setTimeout(() => {
        loading.value = false;
    }, 300);
};

const editarDocumento = (item) => {
    cambiarUrl(route("documentos.edit", item.id));
};

const eliminarDocumento = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar el registro?",
        html: `Paciente: <strong>${item.paciente.full_name}</strong>`,
        showCancelButton: true,
        confirmButtonColor: "#B61431",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await deleteDocumento(item.id);
            if (respuesta && respuesta.sw) {
                recargaDocumentos();
            }
        }
    });
};
const verUbicación = async (item) => {};
</script>
<template>
    <Head title="Documentos"></Head>
    <v-container>
        <BreadBrums :breadbrums="breadbrums"></BreadBrums>
        <v-row class="mt-0">
            <v-col cols="12" class="d-flex justify-end">
                <v-btn
                    color="yellow"
                    prepend-icon="mdi-plus"
                    @click="cambiarUrl(route('documentos.create'))"
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
                                Documentos
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
                            :items="listDocumentos"
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
                                            {{ item.descripcion }}
                                        </td>
                                        <td>
                                            {{ item.documento_archivos.length }}
                                        </td>
                                        <td class="text-right" width="5%">
                                            <v-btn
                                                color="cyan"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="verArchivos(item)"
                                                icon="mdi-paperclip"
                                            ></v-btn>
                                            <v-btn
                                                color="yellow"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="editarDocumento(item)"
                                                icon="mdi-pencil"
                                            ></v-btn>
                                            <v-btn
                                                color="error"
                                                size="small"
                                                class="pa-1 ma-1"
                                                @click="eliminarDocumento(item)"
                                                icon="mdi-trash-can"
                                            ></v-btn>
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
                                                    data-label="Descripción"
                                                >
                                                    {{ item.descripcion }}
                                                </li>
                                                <li
                                                    class="flex-item"
                                                    data-label="Total Archivos"
                                                >
                                                    {{
                                                        item.documento_archivos
                                                            .length
                                                    }}
                                                </li>
                                            </ul>
                                            <v-row>
                                                <v-col
                                                    cols="12"
                                                    class="text-center pa-5"
                                                >
                                                    <v-btn
                                                        color="cyan"
                                                        size="small"
                                                        class="pa-1 ma-1"
                                                        @click="
                                                            verArchivos(item)
                                                        "
                                                        icon="mdi-paperclip"
                                                    ></v-btn>
                                                    <v-btn
                                                        color="yellow"
                                                        size="small"
                                                        class="pa-1 ma-1"
                                                        @click="
                                                            editarDocumento(
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
                                                            eliminarDocumento(
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
        <VerArchivos
            :open_dialog="open_dialog"
            :accion_dialog="accion_dialog"
            @envio-formulario="recargaDocumentos"
            @cerrar-dialog="open_dialog = false"
        ></VerArchivos>
    </v-container>
</template>
