PROGRAM GeneratePublicationList
    IMPLICIT NONE
    CHARACTER(1000) :: bibEntry
    CHARACTER(1000) :: title, authors, journal, volume, pages, year
    INTEGER :: pos1, pos2, pos3, pos4

    ! Inicializar las variables
    title = ''
    authors = ''
    journal = ''
    volume = ''
    pages = ''
    year = ''

    ! Abrir el archivo .bib
    OPEN(1, FILE='../data/ruco-papers.bib', STATUS='OLD', ACTION='READ')

    ! Leer el archivo .bib y extraer la información de cada entrada
    DO
        READ(1, '(A)', END=10) bibEntry
        IF (INDEX(bibEntry, '@article') > 0) THEN
            ! Extraer el título
            pos1 = INDEX(bibEntry, '{') + 1
            pos2 = INDEX(bibEntry, '},')
            title = TRIM(ADJUSTL(bibEntry(pos1:pos2)))

            ! Extraer los autores
            pos3 = INDEX(bibEntry, 'author = {') + 9
            pos4 = INDEX(bibEntry, '},')
            authors = TRIM(ADJUSTL(bibEntry(pos3:pos4)))

            ! Extraer el nombre del journal
            pos1 = INDEX(bibEntry, 'journal = {') + 11
            pos2 = INDEX(bibEntry, '},')
            journal = TRIM(ADJUSTL(bibEntry(pos1:pos2)))

            ! Extraer el volumen
            pos1 = INDEX(bibEntry, 'volume = {') + 10
            pos2 = INDEX(bibEntry, '},')
            volume = TRIM(ADJUSTL(bibEntry(pos1:pos2)))

            ! Extraer las páginas
            pos1 = INDEX(bibEntry, 'pages = {') + 9
            pos2 = INDEX(bibEntry, '},')
            pages = TRIM(ADJUSTL(bibEntry(pos1:pos2)))

            ! Extraer el año
            pos1 = INDEX(bibEntry, 'year = {') + 8
            pos2 = INDEX(bibEntry, '},')
            year = TRIM(ADJUSTL(bibEntry(pos1:pos2)))

            ! Imprimir la entrada en el formato deseado
            IF (LEN_TRIM(year) > 0) THEN
                WRITE(*, '(A)') '    \twentyitemshort{' // TRIM(year) // '}{\color{blue}`' // TRIM(title) // '''\\'
                IF (LEN_TRIM(authors) > 0) THEN
                    WRITE(*, '(A)') '     {' // TRIM(authors) // '}, \\'
                END IF
                IF (LEN_TRIM(journal) > 0) THEN
                    WRITE(*, '(A)') '     ' // TRIM(journal) // ',\textit{' // TRIM(volume) // ', ' // TRIM(pages) // '},\\'
                END IF
                WRITE(*, '(A)') '     \textbf{' // TRIM(year) // '}.\\'
            END IF
        END IF
    END DO

10  CONTINUE

    ! Cerrar el archivo .bib
    CLOSE(1)
END PROGRAM GeneratePublicationList
