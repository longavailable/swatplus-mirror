      subroutine septicparm_read
      
      use input_file_module
      
      character (len=80) :: titldum
      character (len=80) :: header
      character (len=13) :: septdb
      integer :: eof, i, imax
      
      eof = 0
      imax = 0
      msep = 0

      inquire (file=in_parmdb%septic_sep, exist=i_exist)
      if (i_exist == 0 .or. in_parmdb%septic_sep == 'null') then
          allocate (sepdb(0:0))
      else
      do
        open (171,file=in_parmdb%septic_sep)
        read (171,*,iostat=eof) titldum
        if (eof < 0) exit
        read (171,*,iostat=eof) header
        if (eof < 0) exit
           do while (eof == 0) 
             read (171,*,iostat=eof) i
             if (eof < 0) exit
             imax = Max(imax,i)
             msep = msep + 1
           end do
           
        allocate (sepdb(0:imax))        
        rewind (171)
        read (171,*) titldum
        read (171,*) header
    
        do is = 1, msep
          read (171,*,iostat=eof) i
          backspace (171)
          read (171,*,iostat=eof) k, sepdb(i)
          if (eof < 0) exit
        end do

        close (171)
        exit
      enddo
      endif
      
      return
      end  subroutine septicparm_read