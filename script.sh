#!/bin/bash

# Verifica se menu.xml já existe e renomeia se necessário
if [ -f ~/.config/openbox/menu.xml ]; then
  mv ~/.config/openbox/menu.xml ~/.config/openbox/menu_$(date +%Y%m%d%H%M%S).xml
  echo "Arquivo menu.xml já existente renomeado para menu_$(date +%Y%m%d%H%M%S).xml"
fi

# Copia o novo menu.xml para ~/.config/openbox
cp menu.xml ~/.config/openbox/

# Verifica se o wget já está instalado
if ! command -v wget &> /dev/null; then
    # Instala o wget e adiciona as chaves do goto
    apt-get update && apt-get install --yes wget
    wget --quiet --output-document - https://packages.goto.com/goto-keyring | gpg --dearmor --yes --output /usr/share/keyrings/goto-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/goto-keyring.gpg] https://packages.goto.com/deb stable main" | tee /etc/apt/sources.list.d/goto.list
else
    # O wget já está instalado, pula a instalação
    echo "Wget já instalado, continuando..."
    wget --quiet --output-document - https://packages.goto.com/goto-keyring | gpg --dearmor --yes --output /usr/share/keyrings/goto-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/goto-keyring.gpg] https://packages.goto.com/deb stable main" | tee /etc/apt/sources.list.d/goto.list
fi

# Atualiza e instala o rescue-callingcard
apt-get update && apt-get install --yes rescue-callingcard

# Cria o arquivo de configuração para o CallingCard
echo "https://secure.logmeinrescue.com/CallingCard/CallingCardCustomization.aspx?company_id=3394892&channel_id=6063156&lmi_os=linux" | tee /opt/rescue-callingcard/bin/.callingcard

echo "Script concluído com sucesso!"

exit 0