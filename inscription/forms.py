from django import forms
from .models import Inscription

class InscriptionForm(forms.ModelForm):
    class Meta:
        model = Inscription
        fields = [
            'nom', 'prenom', 'niveauEtude', 'email', 'etablissementOrigine',
            'concoursSouhaiter', 'extraitNaissance', 'certificatNationalite',
            'lettreMotivation', 'diplome', 'photo'
        ]
        widgets = {
            'nom': forms.TextInput(attrs={
                'class': 'input input-bordered w-full rounded-lg border-2 border-blue-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 bg-white',
                'placeholder': 'Votre nom'
            }),
            'prenom': forms.TextInput(attrs={
                'class': 'input input-bordered w-full rounded-lg border-2 border-blue-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 bg-white',
                'placeholder': 'Votre prénom'
            }),
            'niveauEtude': forms.TextInput(attrs={
                'class': 'input input-bordered w-full rounded-lg border-2 border-blue-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 bg-white',
                'placeholder': 'Ex: Bac+3, Licence, etc.'
            }),
            'email': forms.EmailInput(attrs={
                'class': 'input input-bordered w-full rounded-lg border-2 border-blue-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 bg-white',
                'placeholder': 'votre.email@exemple.com'
            }),
            'etablissementOrigine': forms.TextInput(attrs={
                'class': 'input input-bordered w-full rounded-lg border-2 border-blue-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 bg-white',
                'placeholder': 'Nom de votre établissement actuel'
            }),
            'concoursSouhaiter': forms.Select(attrs={
                'class': 'select select-bordered w-full rounded-lg border-2 border-blue-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 bg-white'
            }),
            'extraitNaissance': forms.FileInput(attrs={
                'class': 'file-input file-input-bordered w-full rounded-lg border-2 border-purple-300 focus:border-purple-500 focus:ring-2 focus:ring-purple-200 bg-white'
            }),
            'certificatNationalite': forms.FileInput(attrs={
                'class': 'file-input file-input-bordered w-full rounded-lg border-2 border-purple-300 focus:border-purple-500 focus:ring-2 focus:ring-purple-200 bg-white'
            }),
            'lettreMotivation': forms.FileInput(attrs={
                'class': 'file-input file-input-bordered w-full rounded-lg border-2 border-purple-300 focus:border-purple-500 focus:ring-2 focus:ring-purple-200 bg-white'
            }),
            'diplome': forms.FileInput(attrs={
                'class': 'file-input file-input-bordered w-full rounded-lg border-2 border-purple-300 focus:border-purple-500 focus:ring-2 focus:ring-purple-200 bg-white'
            }),
            'photo': forms.FileInput(attrs={
                'class': 'file-input file-input-bordered w-full rounded-lg border-2 border-purple-300 focus:border-purple-500 focus:ring-2 focus:ring-purple-200 bg-white'
            }),
        }