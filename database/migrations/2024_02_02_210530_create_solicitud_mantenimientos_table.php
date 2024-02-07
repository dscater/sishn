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
        Schema::create('solicitud_mantenimientos', function (Blueprint $table) {
            $table->id();
            $table->string("codigo", 255)->unique();
            $table->bigInteger("nro", 255)->unsigned();
            $table->string("nombre_responsable", 300);
            $table->string("ci_responsable", 255)->nullable();
            $table->string("nombre_tecnico", 255)->nullable();
            $table->string("ci_tecnico", 255)->nullable();
            $table->string("tipo_mantenimiento", 255);
            $table->text("motivo_mantenimiento");
            $table->text("diagnostico")->nullable();
            $table->text("otros")->nullable();
            $table->date("fecha_solicitud");
            $table->date("fecha_entrega")->nullable();
            $table->unsignedBigInteger("biometrico_id");
            $table->string("repuestos", 255);
            $table->date("fecha_registro")->nullable();
            $table->timestamps();

            $table->foreign("biometrico_id")->on("biometricos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('solicitud_mantenimientos');
    }
};
