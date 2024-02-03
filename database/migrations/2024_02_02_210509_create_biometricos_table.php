<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('biometricos', function (Blueprint $table) {
            $table->id();
            $table->string("nombre", 255);
            $table->string("estado", 155)->nullable();
            $table->string("marca", 255)->nullable();
            $table->string("serie", 155)->nullable();
            $table->string("modelo", 255)->nullable();
            $table->date("fecha_ingreso");
            $table->string("garantia", 100)->nullable();
            $table->string("cod_hdn", 155)->nullable();
            $table->string("manual_usuario", 255)->nullable();
            $table->string("manual_servicio", 255)->nullable();
            $table->unsignedBigInteger("unidad_area_id");
            $table->unsignedBigInteger("empresa_id");
            $table->string("foto", 255)->nullable();
            $table->date("fecha_registro")->nullable();
            $table->timestamps();

            $table->foreign("unidad_area_id")->on("unidad_areas")->references("id");
            $table->foreign("empresa_id")->on("empresas")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('biometricos');
    }
};
