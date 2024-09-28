function formatAsByteSize(n) {
    //                                              v--------- just in case ---------v
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB", "RB", "QB"]
    let suffix = 0
    while (n >= 1000) {
        suffix += 1
        n /= 1000
    }
    return `${suffix == 0 ? n : n.toPrecision(3)} ${suffixes[suffix]}`
}

export { formatAsByteSize }
