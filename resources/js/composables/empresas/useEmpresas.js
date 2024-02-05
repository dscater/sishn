import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oEmpresa = ref({
    id: 0,
    nombre: "",
    nit: "",
    fono: "",
    fecha_ini: "",
    fecha_fin: "",
    correo: "",
    dir: "",
    logo: "",
    _method: "POST",
});

export const useEmpresas = () => {
    const { flash } = usePage().props;
    const getEmpresas = async () => {
        try {
            const response = await axios.get(route("empresas.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.empresas;
        } catch (err) {
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Error al obtener los registros"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            console.error("Error:", err);
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const getEmpresasByTipo = async (tipo) => {
        try {
            const response = await axios.get(route("empresas.byTipo"), {
                headers: { Accept: "application/json" },
                params: {
                    tipo,
                },
            });
            return response.data.empresas;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    const getItemsForSelect = async (tipo = "") => {
        try {
            const response = await axios.get(route("empresas.byTipo"), {
                headers: { Accept: "application/json" },
                params: {
                    tipo,
                },
            });

            let listItems = response.data.empresas;
            let listSelect = [];
            listItems.forEach((elem) => {
                listSelect.push({
                    value: elem.id,
                    label: elem.full_name,
                });
            });
            return listSelect;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    const getEmpresasApi = async (data) => {
        try {
            const response = await axios.get(route("empresas.paginado", data), {
                headers: { Accept: "application/json" },
            });
            return response.data.empresas;
        } catch (err) {
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Error al obtener los registros"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            console.error("Error:", err);
            throw err; // Puedes manejar el error según tus necesidades
        }
    };
    const saveEmpresa = async (data) => {
        try {
            const response = await axios.post(route("empresas.store", data), {
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

    const deleteEmpresa = async (id) => {
        try {
            const response = await axios.delete(route("empresas.destroy", id), {
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

    const setEmpresa = (item = null) => {
        if (item) {
            oEmpresa.value.id = item.id;
            oEmpresa.value.nombre = item.nombre;
            oEmpresa.value.nit = item.nit;
            oEmpresa.value.fono = item.fono;
            oEmpresa.value.fecha_ini = item.fecha_ini;
            oEmpresa.value.fecha_fin = item.fecha_fin;
            oEmpresa.value.correo = item.correo;
            oEmpresa.value.dir = item.dir;
            oEmpresa.value._method = "PUT";
            return oEmpresa;
        }
        return false;
    };

    const limpiarEmpresa = () => {
        oEmpresa.value.id = 0;
        oEmpresa.value.nombre = "";
        oEmpresa.value.nit = "";
        oEmpresa.value.fono = "";
        oEmpresa.value.fecha_ini = "";
        oEmpresa.value.fecha_fin = "";
        oEmpresa.value.correo = "";
        oEmpresa.value.dir = "";
        oEmpresa.value.logo = "";
        oEmpresa.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oEmpresa,
        getEmpresas,
        getEmpresasApi,
        saveEmpresa,
        deleteEmpresa,
        setEmpresa,
        limpiarEmpresa,
        getEmpresasByTipo,
        getItemsForSelect,
    };
};
