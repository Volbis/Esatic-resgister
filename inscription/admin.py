from django.contrib import admin
from .models import Inscription

@admin.register(Inscription)
class InscriptionAdmin(admin.ModelAdmin):
    # Afficher plus de champs dans la liste des inscriptions
    list_display = ['id', 'nom', 'prenom', 'email']
    