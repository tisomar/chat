<template>
  <v-container>

    <div id="messages">
    <v-row class="fill-height pb-14" align="end">
      <v-col>
        <span class="date" :color="status !== null ? 'red': 'green'"  v-if="status">{{ status }}</span>
        <div v-for="(item, index) in messages" :key="index"
             :class="['d-flex flex-row align-center my-2', item.user == 'Anônimo' ? 'justify-end': null]">
          <span v-if="item.user == 'Anônimo'" class="blue--text mr-3">{{ item.text }}</span>
          <v-avatar :color="item.user == 'Anônimo' ? 'red': 'green'" size="36">
            <span class="white--text">{{ user[0] }}</span>
          </v-avatar>
          <span v-if="item.user != 'Anônimo'" class="blue--text ml-3">{{ item.text}}</span>
        </div>
      </v-col>
    </v-row>

    </div>

    <div class="row">

      <div>
        <v-text-field
            v-model="user"
            label="Usuário"
        ></v-text-field>
      </div>
      <div>
        <v-text-field
            v-model="text"
            label="Mensagem"
            @keyup.enter="sendMessage"
        ></v-text-field>
      </div>
    </div>

  </v-container>
</template>


<script>

export default {
  data: () => ({
    user: 'Anônimo',
    text: null,
    messages: [],
    ws: null,
    status: null
  }),
  // Quando iniciado o aplicativo
  created: function () {
    // Inicia a conexão com o websocket
    this.connect();
  },

  // Métodos do aplicatvo
  methods: {

    // Método responsável por iniciar conexão com o websocket
    connect: function (onOpen) {

      var self = this;

      // Conectando
      self.ws = new WebSocket('ws://localhost:81');

      // Evento que será chamado ao abrir conexão
      self.ws.onopen = function () {
        // self.addSuccessNotification('Conectado');
        self.status = 'Conectado';
        // Se houver método de retorno
        if (onOpen) {
          onOpen();
        }
      };

      // Evento que será chamado quando houver erro na conexão
      self.ws.onerror = function () {
        self.addErrorNotification('Não foi possível conectar-se ao servidor');
      };

      // Evento que será chamado quando recebido dados do servidor
      self.ws.onmessage = function (e) {
        console.log(JSON.parse(e.data));
        self.addMessage(JSON.parse(e.data));
      };

    },

    // Método responsável por adicionar uma mensagem de usuário
    addMessage: function (data) {
      this.messages.push(data);
      this.scrollDown();
    },

    // Método responsável por adicionar uma notificação de sucesso
    addSuccessNotification: function (text) {
      this.addMessage({color: 'green', text: text});
    },

    // Método responsável por adicionar uma notificação de erro
    addErrorNotification: function (text) {
      this.addMessage({color: 'red', text: text});
    },

    // Método responsável por enviar uma mensagem
    sendMessage: function () {

      var self = this;

      // Se não houver o texto da mensagem ou o nome de usuário
      if (!self.text || !self.user) {
        // Saindo do método
        return;
      }

      // Se a conexão não estiver aberta
      if (self.ws.readyState !== self.ws.OPEN) {

        // Exibindo notificação de erro
        self.addErrorNotification('Problemas na conexão. Tentando reconectar...');

        // Tentando conectar novamente e caso tenha sucesso
        // envia a mensagem novamente
        self.connect(function () {
          self.sendMessage();
        });

        // Saindo do método
        return;
      }

      // Envia os dados para o servidor através do websocket
      self.ws.send(JSON.stringify({
        user: self.user,
        text: self.text,
      }));

      // Limpando texto da mensagem
      self.text = null;

    },

    // Método responsável por "rolar" a scroll do chat para baixo
    scrollDown: function () {
      var container = this.$el.querySelector('#messages');
      container.scrollTop = container.scrollHeight;
    },

  }
}
</script>
