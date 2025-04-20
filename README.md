# ExLoader Manager

## Descrição
O ExLoader Manager é uma ferramenta para gerenciar o ExLoader, permitindo abrir o aplicativo, realizar bypass de segurança (limpando logs e configurações), restaurar arquivos previamente apagados e autodestruir o script quando necessário.

## Funcionalidades
- Abrir o ExLoader diretamente
- Realizar bypass (limpar logs e configurações)
- Restaurar arquivos previamente apagados (localmente ou via download online)
- Autodestruição do script após uso

## Como Hospedar

Para hospedar o ExLoader Manager e seus arquivos, você pode usar uma das seguintes opções:

### 1. GitHub
- Crie uma conta no GitHub (se ainda não tiver)
- Crie um novo repositório (pode ser privado)
- Faça upload do arquivo ExLoader_Manager.bat
- Os usuários podem baixar diretamente do GitHub

### 2. Google Drive
- Faça upload do arquivo para o Google Drive
- Gere um link de compartilhamento
- Compartilhe o link com quem precisar usar o script

### 3. Dropbox
- Faça upload para o Dropbox
- Crie um link de compartilhamento
- Compartilhe com os usuários

### 4. Hospedagem Web Simples
- Use serviços como Netlify ou GitHub Pages
- Crie uma página simples com link para download

## Como Usar

1. Baixe o arquivo ExLoader_Manager.bat
2. Execute o arquivo como administrador
3. Selecione a opção desejada no menu:
   - Opção 1: Abre o ExLoader
   - Opção 2: Realiza o bypass (limpa logs e configurações)
   - Opção 3: Restaura arquivos previamente apagados
     - Opção 3.1: Restaura do backup local
     - Opção 3.2: Baixa e restaura arquivos online
   - Opção 4: Sai do programa

## Observações

- Ao realizar o bypass, todos os arquivos são automaticamente copiados para uma pasta de backup temporária
- A opção de restauração local só funcionará se o bypass tiver sido executado anteriormente
- A opção de restauração online baixa os arquivos de um repositório remoto e os instala nas pastas corretas
- Para configurar a restauração online, consulte o arquivo INSTRUCOES_HOSPEDAGEM_ARQUIVOS.md
- A opção de autodestruição (disponível após o bypass) excluirá o script completamente do computador

## Segurança

Este script realiza operações de exclusão de arquivos. Use por sua conta e risco. Recomenda-se fazer backup de arquivos importantes antes de usar a função de bypass.