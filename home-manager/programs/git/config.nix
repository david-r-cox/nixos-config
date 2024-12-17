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
    then "89FA74890EFDDC3B"
    else "918102E888149978";
  signing.signByDefault = true;
}
