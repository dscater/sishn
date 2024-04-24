import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oBiometrico = ref({
    id: 0,
    nombre: "",
    estado: "",
    marca: "",
    serie: "",
    modelo: "",
    fecha_ingreso: "",
    garantia: "",
    cod_hdn: "",
    manual_usuario: "",
    manual_servicio: "",
    unidad_area_id: "",
    empresa_id: "",
    foto: "",
    _method: "POST",
});

export const useBiometricos = () => {
    const { flash } = usePage().props;
    const getBiometricos = async () => {
        try {
            const response = await axios.get(route("biometricos.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.biometricos;
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
    const getBiometricosByArea = async (id) => {
        try {
            const response = await axios.get(route("biometricos.porArea"), {
                headers: { Accept: "application/json" },
                params: {
                    id: id,
                },
            });
            return response.data.biometricos;
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

    const getBiometricosByTipo = async (tipo) => {
        try {
            const response = await axios.get(route("biometricos.byTipo"), {
                headers: { Accept: "application/json" },
                params: {
                    tipo,
                },
            });
            return response.data.biometricos;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    const getBiometricosApi = async (data) => {
        try {
            const response = await axios.get(
                route("biometricos.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.biometricos;
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
    const saveBiometrico = async (data) => {
        try {
            const response = await axios.post(
                route("biometricos.store", data),
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

    const deleteBiometrico = async (id) => {
        try {
            const response = await axios.delete(
                route("biometricos.destroy", id),
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

    const setBiometrico = (item = null) => {
        if (item) {
            oBiometrico.value.id = item.id;
            oBiometrico.value.nombre = item.nombre;
            oBiometrico.value.estado = item.estado;
            oBiometrico.value.marca = item.marca;
            oBiometrico.value.serie = item.serie;
            oBiometrico.value.modelo = item.modelo;
            oBiometrico.value.fecha_ingreso = item.fecha_ingreso;
            oBiometrico.value.garantia = item.garantia;
            oBiometrico.value.cod_hdn = item.cod_hdn;
            oBiometrico.value.manual_usuario = item.manual_usuario;
            oBiometrico.value.manual_servicio = item.manual_servicio;
            oBiometrico.value.unidad_area_id = item.unidad_area_id;
            oBiometrico.value.empresa_id = item.empresa_id;
            oBiometrico.value.foto = item.foto;
            oBiometrico.value._method = "PUT";
            return oBiometrico;
        }
        return false;
    };

    const limpiarBiometrico = () => {
        oBiometrico.value.id = 0;
        oBiometrico.value.nombre = "";
        oBiometrico.value.estado = "";
        oBiometrico.value.marca = "";
        oBiometrico.value.serie = "";
        oBiometrico.value.modelo = "";
        oBiometrico.value.fecha_ingreso = "";
        oBiometrico.value.garantia = "";
        oBiometrico.value.cod_hdn = "";
        oBiometrico.value.manual_usuario = "";
        oBiometrico.value.manual_servicio = "";
        oBiometrico.value.unidad_area_id = "";
        oBiometrico.value.empresa_id = "";
        oBiometrico.value.foto = "";
        oBiometrico.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oBiometrico,
        getBiometricos,
        getBiometricosByArea,
        getBiometricosApi,
        saveBiometrico,
        deleteBiometrico,
        setBiometrico,
        limpiarBiometrico,
        getBiometricosByTipo,
    };
};
