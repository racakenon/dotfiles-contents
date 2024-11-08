# Retrieve the theme settings
export def main [] {
    return {
        binary: '#D1AEE1'
        block: '#A9BBF2'
        cell-path: '#BDBBC9'
        closure: '#83C9E4'
        custom: '#EEF0E1'
        duration: '#EEF0E1'
        float: '#E9A8BB'
        glob: '#EEF0E1'
        int: '#D1AEE1'
        list: '#83C9E4'
        nothing: '#E9A8BB'
        range: '#EEF0E1'
        record: '#83C9E4'
        string: '#E9A8BB'

        bool: {|| if $in { '#83C9E4' } else { '#EEF0E1' } }

        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#E9A8BB' attr: 'b' }
            } else if $in < 6hr {
                '#E9A8BB'
            } else if $in < 1day {
                '#EEF0E1'
            } else if $in < 3day {
                '#E9A8BB'
            } else if $in < 1wk {
                { fg: '#E9A8BB' attr: 'b' }
            } else if $in < 6wk {
                '#83C9E4'
            } else if $in < 52wk {
                '#A9BBF2'
            } else { '#BDBBC9' }
        }

        filesize: {|e|
            if $e == 0b {
                '#BDBFB0'
            } else if $e < 1mb {
                '#83C9E4'
            } else {{ fg: '#A9BBF2' }}
        }

        shape_and: { fg: '#D1AEE1' attr: 'b' }
        shape_binary: { fg: '#D1AEE1' attr: 'b' }
        shape_block: { fg: '#A9BBF2' attr: 'b' }
        shape_bool: '#83C9E4'
        shape_closure: { fg: '#83C9E4' attr: 'b' }
        shape_custom: '#E9A8BB'
        shape_datetime: { fg: '#83C9E4' attr: 'b' }
        shape_directory: '#83C9E4'
        shape_external: '#83C9E4'
        shape_external_resolved: '#83C9E4'
        shape_externalarg: { fg: '#E9A8BB' attr: 'b' }
        shape_filepath: '#83C9E4'
        shape_flag: { fg: '#A9BBF2' attr: 'b' }
        shape_float: { fg: '#E9A8BB' attr: 'b' }
        shape_garbage: { fg: '#BDBBC9' bg: '#E9A8BB' attr: 'b' }
        shape_glob_interpolation: { fg: '#83C9E4' attr: 'b' }
        shape_globpattern: { fg: '#83C9E4' attr: 'b' }
        shape_int: { fg: '#D1AEE1' attr: 'b' }
        shape_internalcall: { fg: '#83C9E4' attr: 'b' }
        shape_keyword: { fg: '#D1AEE1' attr: 'b' }
        shape_list: { fg: '#83C9E4' attr: 'b' }
        shape_literal: '#A9BBF2'
        shape_match_pattern: '#E9A8BB'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#E9A8BB'
        shape_operator: '#EEF0E1'
        shape_or: { fg: '#D1AEE1' attr: 'b' }
        shape_pipe: { fg: '#D1AEE1' attr: 'b' }
        shape_range: { fg: '#EEF0E1' attr: 'b' }
        shape_raw_string: { fg: '#EEF0E1' attr: 'b' }
        shape_record: { fg: '#83C9E4' attr: 'b' }
        shape_redirection: { fg: '#D1AEE1' attr: 'b' }
        shape_signature: { fg: '#E9A8BB' attr: 'b' }
        shape_string: '#E9A8BB'
        shape_string_interpolation: { fg: '#83C9E4' attr: 'b' }
        shape_table: { fg: '#A9BBF2' attr: 'b' }
        shape_vardecl: { fg: '#A9BBF2' attr: 'u' }
        shape_variable: '#D1AEE1'

        foreground: '#EEF0E1'
        background: '#2D2C37'
        cursor: '#BDBFB0'

        empty: '#A9BBF2'
        header: { fg: '#E9A8BB' attr: 'b' }
        hints: '#bdae93'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#E9A8BB' attr: 'b' }
        search_result: { fg: '#E9A8BB' bg: '#BDBBC9' }
        separator: '#BDBBC9'
    }
}

# Update the Nushell configuration
export def --env "set color_config" [] {
    $env.config.color_config = (main)
}

# Update terminal colors
export def "update terminal" [] {
    let theme = (main)

    # Set terminal colors
    let osc_screen_foreground_color = '10;'
    let osc_screen_background_color = '11;'
    let osc_cursor_color = '12;'
        
    $"
    (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
    (ansi -o $osc_screen_background_color)($theme.background)(char bel)
    (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
    "
    # Line breaks above are just for source readability
    # but create extra whitespace when activating. Collapse
    # to one line and print with no-newline
    | str replace --all "\n" ''
    | print -n $"($in)\r"
}

export module activate {
    export-env {
        set color_config
        update terminal
    }
}

# Activate the theme when sourced
use activate
