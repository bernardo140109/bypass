# Instruções para Hospedar Arquivos do ExLoader para Download Online

Este documento explica como hospedar os arquivos necessários para a função de restauração online do ExLoader Manager.

## Arquivos Necessários para Hospedagem

Você precisará preparar e hospedar os seguintes arquivos ZIP:

1. `logs.zip` - Backup dos logs do ExLoader
2. `config.zip` - Backup das configurações do ExLoader
3. `Luno.zip` - Backup da pasta Luno
4. `ExHack.zip` - Backup da pasta ExHack
5. `en1gma-tech.zip` - Backup da pasta en1gma-tech
6. `SharkHack.zip` - Backup da pasta SharkHack

## Como Preparar os Arquivos ZIP

1. **Crie backups das pastas originais**:
   - Execute o ExLoader Manager e use a opção de bypass para criar backups
   - Os backups serão salvos em `%TEMP%\ExLoader_Backup\`

2. **Crie os arquivos ZIP**:
   - Navegue até `%TEMP%\ExLoader_Backup\`
   - Para cada pasta, crie um arquivo ZIP correspondente
   - Certifique-se de que a estrutura de pastas dentro do ZIP seja mantida

## Opções de Hospedagem

### GitHub (Recomendado)

1. Crie um repositório no GitHub (pode ser privado)
2. Faça upload de todos os arquivos ZIP
3. Obtenha os links diretos para cada arquivo:
   - Navegue até o arquivo no GitHub
   - Clique em "Raw" ou use o formato: `https://github.com/seu-usuario/seu-repositorio/raw/main/nome-do-arquivo.zip`
4. Atualize o script ExLoader_Manager.bat com os links corretos

### Google Drive

1. Faça upload dos arquivos ZIP para o Google Drive
2. Gere links de compartilhamento para cada arquivo:
   - Clique com o botão direito no arquivo
   - Selecione "Compartilhar" > "Obter link"
   - Ajuste as permissões para "Qualquer pessoa com o link"
3. Modifique os links para download direto:
   - Substitua `https://drive.google.com/file/d/ID_DO_ARQUIVO/view?usp=sharing` por `https://drive.google.com/uc?export=download&id=ID_DO_ARQUIVO`
4. Atualize o script ExLoader_Manager.bat com os links corretos

### Dropbox

1. Faça upload dos arquivos ZIP para o Dropbox
2. Gere links de compartilhamento para cada arquivo
3. Modifique os links para download direto:
   - Substitua `?dl=0` por `?dl=1` no final do link
4. Atualize o script ExLoader_Manager.bat com os links corretos

## Configurando o ExLoader_Manager.bat

Após hospedar os arquivos, você precisa atualizar as URLs no script ExLoader_Manager.bat:

```batch
:: URLs dos arquivos hospedados online (substitua pelos links reais)
set "URL_LOGS=https://github.com/seu-usuario/ExLoader-Files/raw/main/logs.zip"
set "URL_CONFIG=https://github.com/seu-usuario/ExLoader-Files/raw/main/config.zip"
set "URL_LUNO=https://github.com/seu-usuario/ExLoader-Files/raw/main/Luno.zip"
set "URL_EXHACK=https://github.com/seu-usuario/ExLoader-Files/raw/main/ExHack.zip"
set "URL_ENIGMA=https://github.com/seu-usuario/ExLoader-Files/raw/main/en1gma-tech.zip"
set "URL_SHARK=https://github.com/seu-usuario/ExLoader-Files/raw/main/SharkHack.zip"
```

Substitua os URLs de exemplo pelos links diretos para seus arquivos hospedados.

## Observações Importantes

- Certifique-se de que os links permitem download direto sem autenticação
- Teste os links antes de distribuir o script
- Considere atualizar os arquivos hospedados periodicamente com backups mais recentes
- Por segurança, considere usar um repositório privado e compartilhar apenas com pessoas de confiança