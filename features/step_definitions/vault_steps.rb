Given 'a vault named "$name"' do |name|
  Vault.create!(
    :name => name,
    # password = "password"
    :key => <<-EOF
U2FsdGVkX19oDccXHPRVxh6BbH1qrnEuwymj2igXlhHoQZzQhGAV8Mwr3zzbVSVY
+9nwKwqgUxjsFbGgFFR6+DoHuXz62pFXp1oeR2xd6JyNaJIW8Xk/1N6Wtm0Tur3Q
m/3N7HU63OG7qLj0t+tfWta5t3hV9gR4pUiTz+1EXvz6TJe8RfFd6HSJVVYmlbK/
FeJcdpgPzpvaeUVemC6tSg==
EOF
  )
end