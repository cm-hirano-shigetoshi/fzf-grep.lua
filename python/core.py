import utils

directory = "."
binds = {
    "alt-u": {"cd": "up"},
}


def get_source():
    return f"rg -n ^ {directory}"


def cd_up():
    global directory
    directory += "/.."


def bind(key):
    operation = binds[key]
    if src := operation.get("reload"):
        utils.request_fzf(data=f"reload({src})")
    elif operation.get("cd"):
        cd_up()
        utils.request_fzf(data=f"reload({get_source()})")
