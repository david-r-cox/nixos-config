{ isCorp }:
{
  enable = true;
  userName = "David Cox";
  userEmail =
    if isCorp
    then "david@integrated-reasoning.com"
    else "david_cox@hey.com";
  signing.key =
    if isCorp
    then "65BB07FAA4D94634"
    else "918102E888149978";
  signing.signByDefault = true;
}
