# Menggunakan Node.js sebagai base image
FROM node:14

# Membuat direktori kerja di dalam container
WORKDIR /app

# Menyalin package.json dan package-lock.json ke dalam container
COPY package*.json ./

# Menginstal dependensi Node.js
RUN npm install

# Menggunakan image Python terbaru, menginstal Python dan pip terbaru
FROM python:3.10-slim

# Membuat direktori kerja di dalam container untuk aplikasi Python
WORKDIR /app

# Upgrade pip untuk Python dan install opencv-python
RUN pip install --no-cache-dir --upgrade pip && \
    pip install opencv-python

# Menyalin requirements.txt dan menginstal dependensi Python lainnya
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Menyalin kode aplikasi ke dalam container
COPY . .

# Mengexpose port yang dibutuhkan oleh aplikasi Node.js dan Python
EXPOSE 8000

# Menjalankan aplikasi Node.js saat container berjalan
CMD ["node", "server.js"]
