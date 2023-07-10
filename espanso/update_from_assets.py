import os


def generate(path, output_file, prefix):
    files = [
        f for f in os.listdir(path) if os.path.isfile(os.path.join(path, f))
    ]

    with open(output_file, 'w') as f:
        f.write('matches:\n')

        for file in files:
            path_wo_ext = os.path.splitext(file)[0]
            f.write('  - trigger: ;;' + prefix + path_wo_ext + '\n')
            f.write(
                '    image_path: $CONFIG/' + path + '/' + file + '\n')


if __name__ == '__main__':
    generate('assets/img', 'match/img.yml', 'i')
    generate('assets/gif', 'match/gif.yml', 'g')
