# Menggunakan Node.js sebagai base image
FROM node:14

# Membuat direktori kerja di dalam container
WORKDIR /app

# Menyalin package.json dan package-lock.json ke dalam container
COPY package*.json ./

# Menginstal dependensi
RUN npm install

# Install Python 3 and its dependencies
RUN apt-get update && apt-get install -y python3 python3-pip

# Menyalin package.json dan package-lock.json ke dalam container
COPY package*.json ./

# Upgrade pip for Python 3
RUN python3 -m pip install --no-cache-dir --upgrade pip

# Copy requirements.txt and install Python dependencies
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt

# Menyalin kode aplikasi ke dalam container
COPY . .

# Mengexpose port 8000
EXPOSE 8000

# Menjalankan aplikasi saat container berjalan
CMD ["node", "server.js"]