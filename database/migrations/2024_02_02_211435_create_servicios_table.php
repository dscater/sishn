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
        Schema::create('servicios', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("solicitud_mantenimiento_id");
            $table->date("fecha_entrega");
            $table->text("procedimientos");
            $table->text("observaciones")->nullable();
            $table->text("recomendaciones")->nullable();
            $table->text("diagnostico_previo")->nullable();
            $table->string("estado_equipo", 300)->nullable();
            $table->text("trabajo_realizado");
            $table->string("capacitacion", 20);
            $table->date("fecha_registro");
            $table->timestamps();

            $table->foreign("solicitud_mantenimiento_id")->on("solicitud_mantenimientos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('servicios');
    }
};
