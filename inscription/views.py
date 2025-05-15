from django.shortcuts import render, redirect
from .forms import InscriptionForm
from .models import Inscription
import uuid

def home(request):
    return render(request, 'home.html')

def inscription(request):
    if request.method == 'POST':
        form = InscriptionForm(request.POST, request.FILES)
        if form.is_valid():
            # Generate a unique inscription number
            inscription = form.save(commit=False)
            inscription.numero_inscription = str(uuid.uuid4())[:8].upper()
            inscription.save()
            return redirect('inscription:success')
    else:
        form = InscriptionForm()
    return render(request, 'inscription.html', {'form': form})

def success(request):
    return render(request, 'success.html')