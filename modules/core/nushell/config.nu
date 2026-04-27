$env.config.show_banner = false
$env.EDITOR = "hx"
$env.config.buffer_editor = $env.EDITOR


# Make a directory and then immediately enter it
def --env mkcd [
    path: string # The directory to be made
] {
    mkdir $path
    cd $path
}
