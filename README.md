# Docker s3fs
Docker to create the s3fs service

## How to build

`docker build -t wuakitv/s3fs .`

## How to run
`docker run --rm -v /mnt/#{SRC_BUCKET}:/mnt/#{SRC_BUCKET}:shared -v /usr/share/s3fs:/usr/share/s3fs --security-opt apparmor:unconfined --device=/dev/fuse --cap-add mknod --cap-add sys_admin wuakitv/s3fs:latest s3fs #{SRC_BUCKET} /mnt/#{SRC_BUCKET} -f -o dbglevel=info -o passwd_file=/usr/share/s3fs/passwd-s3fs -o ro -o allow_other`

Note: this container does not return when run with -f, it keeps open
