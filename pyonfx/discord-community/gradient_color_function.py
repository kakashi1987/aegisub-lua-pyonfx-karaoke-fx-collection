def gradient_color(index, total, ran_colors):
    if len(ran_colors) != 4:
        raise ValueError("Four color strings ONLY.")

    if index == total - 1:
        return ran_colors[-1]

    quarter = total / 4
    if index < quarter:
        factor = index / quarter
        return interpolate_color(ran_colors[0], ran_colors[1], factor)
    elif index < 2 * quarter:
        factor = (index - quarter) / quarter
        return interpolate_color(ran_colors[1], ran_colors[2], factor)
    elif index < 3 * quarter:
        factor = (index - 2 * quarter) / quarter
        return interpolate_color(ran_colors[2], ran_colors[3], factor)
    else:
        factor = (index - 3 * quarter) / quarter
        return interpolate_color(ran_colors[3], ran_colors[0], factor)
    for i, (x, y) in enumerate(fill_order):
        color_ass_format = gradient_color(i, len(fill_order), ran_colors)