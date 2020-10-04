COMPARATOR_DICT = {
    'exactly': '',
    'on': '',
    'less than': '<',
    'before': '<',
    'greater than': '>',
    'more than': '>',
    'after': '>',
    'less or equal than': '<=',
    'on or before': '<=',
    'greater or equal than': '>=',
    'more or equal than': '>=',
    'on or after': '>='
}


def get_comparator(str_comparator):
    if str_comparator not in COMPARATOR_DICT: raise Exception("Unrecognized comparator '{}'".format(str_comparator))
    return COMPARATOR_DICT[str_comparator]


def table_to_query_args(table):
    query_args = {}
    for row in table:
        key = str(row[0]).lower()
        if key in ['is', 'in']:
            key = 'q_' + key
        if key not in query_args:
            query_args.update({key: row[1]})
        else:
            if not isinstance(query_args[key], list):
                query_args[key] = [query_args[key]]
            query_args[key].append(row[1])
    return query_args


def get_order(str_order):
    if str_order in ['asc', 'ascending']:
        return 'asc'
    else:
        return 'desc'
