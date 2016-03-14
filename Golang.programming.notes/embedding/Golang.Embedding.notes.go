Golang Embedding
=============================================
Go does not provide the typical, type-driven notion
of subclassing, but it does have the ability to "borrow"
pieces of an implementation by embedding types within a struct
interface.

Interace embedding is very simple. We've mentioned the io.Reader and io.Writer
inerfaces before; hwere are their definitions
=============================================

type Reader interface{
	Read(p []byte)(n int, err error)
}

typer Writer interface{
	Write(p []byte)(n int, err error)
}

The io package also exports several other interfaces that specify objects
that can implement several such methods.  For instance, here is io.ReadWriter,
an interface containing both Read and Write:
We could specfy
io.ReadWriter by listing the two methods explicity, but it is easier and more evocative
to embed the two interfaes to form the new one, as so:

type Reader interface{
	Read(p []byte)(n int, err error)
}
typer Writer interface{
	Write(p []byte)(n int, err error)
}
type ReadWriter interface{
	Reader
	Writer
}