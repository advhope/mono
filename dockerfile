# Wybierz obraz bazowy
FROM python:3.12

# Ustaw katalog roboczy
WORKDIR /app

# Skopiuj pliki wymagań i zainstaluj zależności
COPY requirements.txt .
RUN pip install -r requirements.txt

# Skopiuj resztę kodu źródłowego aplikacji
COPY . /app

# Ustaw zmienną środowiskową używaną przez Django do uruchomienia w trybie produkcyjnym
ENV DJANGO_SETTINGS_MODULE=myproject.settings.prod

# Uruchom migracje, zbierz pliki statyczne, itp.
RUN python manage.py migrate
RUN python manage.py collectstatic --noinput

# Poinformuj Docker, że kontener nasłuchuje na określonym porcie
EXPOSE 8000

# Uruchom serwer aplikacji Django
CMD ["gunicorn", "-b", "0.0.0.0:8000", "myproject.wsgi:application"]
