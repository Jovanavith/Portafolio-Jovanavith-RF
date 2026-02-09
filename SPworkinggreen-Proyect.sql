--SP insert de cliente y Orden 
CREATE OR ALTER PROCEDURE spInsertClienteOrden
		@NombreCliente       VARCHAR(100),
		@Direccion           VARCHAR(200)     = NULL,
		@Ciudad              VARCHAR(100)     = NULL,
		@Pais                VARCHAR(100)     = NULL,
		@CodigoPostal        VARCHAR(20)      = NULL,
		@Telefono            VARCHAR(30)      = NULL,

		@IDCurso             INT,
		@Precio              DECIMAL(12,2),

		@IDTipoPago          INT             = NULL,
		@ReferenciaPago      VARCHAR(200)    = NULL
		
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;
	DECLARE @PersonaRegistra   VARCHAR(100) = 'Sistema'
	--Insertar al cliente
	INSERT INTO Clientes (NombreCliente, Direccion, Ciudad, Pais, CodigoPostal, Telefono,
                              PersonaRegistra, FechaRegistro)
        VALUES (@NombreCliente, @Direccion, @Ciudad, @Pais, @CodigoPostal, @Telefono,
                @PersonaRegistra, GETDATE());

        DECLARE @IDCliente INT = SCOPE_IDENTITY();


    --Creacion Orden
    INSERT INTO Orden (IDCliente, FechaDeOrden, PersonaRegistra, FechaRegistro)
        VALUES (@IDCliente, GETDATE(), @PersonaRegistra, GETDATE());

        DECLARE @IDOrden INT = SCOPE_IDENTITY();


    --Creacion Detalles de la orden    
    INSERT INTO OrderDetails (IDOrden, IDCurso, Precio, Descuento, PersonaRegistra, FechaRegistro)
        VALUES (@IDOrden, @IDCurso, @Precio, 0.00, @PersonaRegistra, GETDATE());

        DECLARE @IDOrderDetail INT = SCOPE_IDENTITY();

	--Registrar Pago
	IF @IDTipoPago IS NOT NULL
        BEGIN
            INSERT INTO Pagos (IDOrderDetail, IDTipoPago, FechaPago, MontoPagado,
                               ReferenciaPago, PersonaRegistra, FechaRegistro)
            VALUES (@IDOrderDetail, @IDTipoPago, GETDATE(), @Precio,
                    @ReferenciaPago, @PersonaRegistra, GETDATE());
        END

	--Rararara
	COMMIT;
        SELECT 
            1 AS Code,
            'Compra registrada correctamente.' AS Msg,
            @IDCliente AS IDCliente,
            @IDOrden AS IDOrden,
            @IDOrderDetail AS IDOrderDetail;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        SELECT 
            -1 AS Code,
            ERROR_MESSAGE() AS Msg;
    END CATCH
END;
