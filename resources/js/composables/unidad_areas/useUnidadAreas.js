import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oUnidadArea = ref({
    id: 0,
    nombre: "",
    descripcion: "",
    user_id: "",
    ubicacion: "",
    unidad: "",
    _method: "POST",
});

export const useUnidadAreas = () => {
    const { flash } = usePage().props;
    const getUnidadAreas = async () => {
        try {
            const response = await axios.get(route("unidad_areas.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.unidad_areas;
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

    const getUnidadAreasApi = async (data) => {
        try {
            const response = await axios.get(
                route("unidad_areas.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.unidad_areas;
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
    const saveUnidadArea = async (data) => {
        try {
            const response = await axios.post(
                route("unidad_areas.store", data),
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

    const deleteUnidadArea = async (id) => {
        try {
            const response = await axios.delete(
                route("unidad_areas.destroy", id),
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

    const setUnidadArea = (item = null) => {
        if (item) {
            oUnidadArea.value.id = item.id;
            oUnidadArea.value.nombre = item.nombre;
            oUnidadArea.value.descripcion = item.descripcion;
            oUnidadArea.value.user_id = item.user_id;
            oUnidadArea.value.ubicacion = item.ubicacion;
            oUnidadArea.value.unidad = item.unidad;
            oUnidadArea.value._method = "PUT";
            return oUnidadArea;
        }
        return false;
    };

    const limpiarUnidadArea = () => {
        oUnidadArea.value.id = 0;
        oUnidadArea.value.nombre = "";
        oUnidadArea.value.descripcion = "";
        oUnidadArea.value.user_id = "";
        oUnidadArea.value.ubicacion = "";
        oUnidadArea.value.unidad = "";
        oUnidadArea.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oUnidadArea,
        getUnidadAreas,
        getUnidadAreasApi,
        saveUnidadArea,
        deleteUnidadArea,
        setUnidadArea,
        limpiarUnidadArea,
    };
};
