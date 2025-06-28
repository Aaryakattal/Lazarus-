import google.generativeai as genai

def chat():
    GOOGLE_API_KEY = "(insert api key here)"
    genai.configure(api_key=GOOGLE_API_KEY)

    print("Hello! I'm your personal assistant Lazurus, how can I help you (user name)? Type 'exit' to stop.")

    model = genai.GenerativeModel('gemini-1.5-flash')

    while True:
        user_input = input("> ")
        if user_input.lower() == "exit":
            print("Goodbye!")
            break

        response = model.generate_content(
            f"You are a helpful assistant. User said: {user_input}"
        )
        print(response.text)

if __name__ == "__main__":
    chat()
