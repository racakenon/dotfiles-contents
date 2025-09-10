function ll
  if type -q eza
    eza -lh $argv
  else
    command ls -lh $argv
  end
end
