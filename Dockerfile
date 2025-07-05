FROM python:3.13.4-alpine3.22

# 2. Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro para aproveitar o cache do Docker.
# A camada de instalação de dependências só será reconstruída se o requirements.txt mudar.
COPY requirements.txt .

# 4. Instalar as dependências.
# --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o resto do código da aplicação para o diretório de trabalho.
COPY . .

# 6. Expor a porta que a aplicação usará.
EXPOSE 8000

# 7. Definir o comando para executar a aplicação quando o contêiner iniciar.
# Usamos --host 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]