class Home::IndexPage < GuestLayout
  include React::Component

  def content
    h1 "React Component"

    messages = [
      { id: 1, sender: "me", text: "Hi" },
      { id: 2, sender: "Chatbot", text: "Hi! How can I help?" },
      { id: 3, sender: "me", text: "Can you tell me the time?" },
      { id: 4, sender: "Chatbot", text: "Sure it's #{Time.now}" }
    ]

    react "Chat", { messages: messages }
  end
end
