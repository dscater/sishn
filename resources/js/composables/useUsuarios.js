import axios from "axios";
import { onMounted, ref } from "vue";

export const useUsuarios = () => {
    const getUsuarios = async () => {
        try {
            const response = await axios.get(route("usuarios.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.usuarios;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    const getUsuariosPaginado = async (data) => {
        try {
            const response = await axios.get(route("usuarios.paginado", data), {
                headers: { Accept: "application/json" },
            });
            return response.data.usuarios;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    const saveUsuario = async (data) => {
        try {
            const response = await axios.post(route("usuarios.store", data), {
                headers: { Accept: "application/json" },
            });
            return response.data;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    onMounted(() => {});

    return {
        getUsuarios,
        getUsuariosPaginado,
        saveUsuario,
    };
};
