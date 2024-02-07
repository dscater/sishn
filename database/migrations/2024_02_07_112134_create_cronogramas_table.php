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
        Schema::create('cronogramas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("solicitud_mantenimiento_id");
            $table->text("descripcion");
            $table->date("date");
            $table->unsignedBigInteger("user_id");
            $table->timestamps();

            $table->foreign("solicitud_mantenimiento_id")->on("solicitud_mantenimientos")->references("id");
            $table->foreign("user_id")->on("users")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cronogramas');
    }
};
