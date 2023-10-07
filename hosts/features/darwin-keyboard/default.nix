{ ... }: {
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
    userKeyMapping = [
      {
        HIDKeyboardModifierMappingSrc = 30064771296; # lctl
        HIDKeyboardModifierMappingDst = 30064771299; # lcmd
      }
      {
        HIDKeyboardModifierMappingSrc = 30064771299; # lcmd
        HIDKeyboardModifierMappingDst = 30064771296; # lctl
      }
      {
        HIDKeyboardModifierMappingSrc = 30064771303; # rcmd
        HIDKeyboardModifierMappingDst = 30064771302; # ropt
      }
      {
        HIDKeyboardModifierMappingSrc = 30064771302; # ropt
        HIDKeyboardModifierMappingDst = 30064771303; # rcmd
      }
    ];
  };
}
