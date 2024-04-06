import axios from "axios";
import { onMounted, reactive } from "vue";
import { usePage } from "@inertiajs/vue3";

const oDocumento = reactive({
    id: 0,
    descripcion: "",
    documento_archivos: reactive([]),
    _method: "POST",
});

export const useDocumentos = () => {
    const { flash } = usePage().props;
    const getDocumentos = async () => {
        try {
            const response = await axios.get(route("documentos.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.documentos;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const getDocumentosApi = async (data) => {
        try {
            const response = await axios.get(
                route("documentos.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.documentos;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };
    const saveDocumento = async (data) => {
        try {
            const response = await axios.post(route("documentos.store", data), {
                headers: { Accept: "application/json" },
            });
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            console.error("Error:", err);
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const deleteDocumento = async (id) => {
        try {
            const response = await axios.delete(
                route("documentos.destroy", id),
                {
                    headers: { Accept: "application/json" },
                }
            );
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            console.error("Error:", err);
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const setDocumento = (item = null, archivos = false) => {
        if (item) {
            oDocumento.id = item.id;
            oDocumento.descripcion = item.descripcion;
            oDocumento.documento_archivos = reactive([]);
            if (archivos) {
                oDocumento.documento_archivos = reactive([
                    ...item.documento_archivos,
                ]);
            }
            oDocumento._method = "PUT";
            return oDocumento;
        }
        return false;
    };

    const limpiarDocumento = () => {
        oDocumento.id = 0;
        oDocumento.descripcion = "";
        oDocumento.documento_archivos = reactive([]);
        oDocumento._method = "POST";
    };

    onMounted(() => {});

    return {
        oDocumento,
        getDocumentos,
        getDocumentosApi,
        saveDocumento,
        deleteDocumento,
        setDocumento,
        limpiarDocumento,
    };
};
